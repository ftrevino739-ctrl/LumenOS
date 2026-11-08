#!/usr/bin/env bash
set -Eeuo pipefail

BASE_URL="https://cdimage.ubuntu.com/cdimage/kubuntu/releases/26.04.1/release"
ISO_NAME="kubuntu-26.04.1-desktop-amd64.iso"

usage() {
  echo "Usage: sudo $0 /path/to/${ISO_NAME} /path/to/lumen-desktop-0.2.0-Linux.deb /path/to/Lumen-26.04.1-amd64.iso"
}

if [[ "${EUID}" -ne 0 ]]; then
  echo "Run this ISO builder with sudo; it uses a temporary chroot and loop mount." >&2
  usage
  exit 2
fi
if [[ "$#" -ne 3 ]]; then
  usage
  exit 2
fi

BASE_ISO="$(realpath "$1")"
LUMEN_DEB="$(realpath "$2")"
OUTPUT_ISO="$(realpath -m "$3")"
OUTPUT_DIR="$(dirname "$OUTPUT_ISO")"

[[ -f "$BASE_ISO" && -f "$LUMEN_DEB" ]] || {
  echo "Input ISO or Lumen Debian package not found." >&2
  exit 2
}
[[ ! -e "$OUTPUT_ISO" ]] || {
  echo "Refusing to overwrite existing output: $OUTPUT_ISO" >&2
  exit 2
}
[[ "$(basename "$BASE_ISO")" == "$ISO_NAME" ]] || {
  echo "Expected the official Kubuntu 26.04.1 image named $ISO_NAME." >&2
  exit 2
}

for command in curl sha256sum mount umount mountpoint unsquashfs mksquashfs xorriso chroot awk du df apt-get nproc realpath; do
  command -v "$command" >/dev/null 2>&1 || {
    echo "Missing required command: $command" >&2
    exit 2
  }
done

mkdir -p "$OUTPUT_DIR"
AVAILABLE_KB="$(df -Pk "$OUTPUT_DIR" | awk 'NR==2 {print $4}')"
if (( AVAILABLE_KB < 26214400 )); then
  echo "At least 25 GiB of free space is required in $OUTPUT_DIR." >&2
  exit 2
fi

BUILD_OK=0
WORK="$(mktemp -d "$OUTPUT_DIR/.lumen-iso.XXXXXX")"
ISO_MOUNT="$WORK/iso"
ROOTFS="$WORK/rootfs"
mkdir -p "$ISO_MOUNT" "$ROOTFS"

cleanup() {
  set +e
  for target in "$ROOTFS/run" "$ROOTFS/sys" "$ROOTFS/proc" "$ROOTFS/dev/pts" "$ROOTFS/dev"; do
    if mountpoint -q "$target"; then umount -lf "$target"; fi
  done
  if mountpoint -q "$ISO_MOUNT"; then umount "$ISO_MOUNT"; fi
  if [[ "$BUILD_OK" -ne 1 ]]; then rm -f "$OUTPUT_ISO" "${OUTPUT_ISO}.sha256"; fi
  rm -rf "$WORK"
}
trap cleanup EXIT INT TERM

echo "Verifying the official Kubuntu 26.04.1 ISO checksum..."
curl -fsSL "$BASE_URL/SHA256SUMS" -o "$WORK/SHA256SUMS"
EXPECTED_SHA="$(awk -v name="$ISO_NAME" '$2 == name || $2 == "*" name {print $1}' "$WORK/SHA256SUMS")"
ACTUAL_SHA="$(sha256sum "$BASE_ISO" | awk '{print $1}')"
[[ -n "$EXPECTED_SHA" && "$ACTUAL_SHA" == "$EXPECTED_SHA" ]] || {
  echo "ISO checksum mismatch. Do not continue with an unverified base image." >&2
  exit 1
}

echo "Mounting base image and extracting the live filesystem..."
mount -o loop,ro "$BASE_ISO" "$ISO_MOUNT"
[[ -f "$ISO_MOUNT/casper/filesystem.squashfs" && -f "$ISO_MOUNT/md5sum.txt" ]] || {
  echo "The supplied image does not have the expected Kubuntu casper layout." >&2
  exit 1
}
unsquashfs -no-progress -d "$ROOTFS" "$ISO_MOUNT/casper/filesystem.squashfs"

echo "Preparing the chroot and installing the Lumen package..."
install -d "$ROOTFS/tmp/lumen-build" "$ROOTFS/etc/skel/.config"
install -m 0644 "$LUMEN_DEB" "$ROOTFS/tmp/lumen-build/lumen-desktop.deb"
rm -f "$ROOTFS/etc/resolv.conf"
cp -L /etc/resolv.conf "$ROOTFS/etc/resolv.conf"

mount --bind /dev "$ROOTFS/dev"
mount --bind /dev/pts "$ROOTFS/dev/pts"
mount -t proc proc "$ROOTFS/proc"
mount -t sysfs sysfs "$ROOTFS/sys"
mount --bind /run "$ROOTFS/run"

chroot "$ROOTFS" apt-get update
chroot "$ROOTFS" env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends /tmp/lumen-build/lumen-desktop.deb
chroot "$ROOTFS" apt-get clean

cat > "$ROOTFS/etc/skel/.config/kdeglobals" <<'EOF'
[General]
ColorScheme=Lumen
EOF
cat > "$ROOTFS/etc/skel/.config/plasmarc" <<'EOF'
[Theme]
name=lumen
EOF

rm -f "$ROOTFS/tmp/lumen-build/lumen-desktop.deb"
rm -rf "$ROOTFS/var/lib/apt/lists/"*

for target in "$ROOTFS/run" "$ROOTFS/sys" "$ROOTFS/proc" "$ROOTFS/dev/pts" "$ROOTFS/dev"; do
  umount "$target"
done

echo "Rebuilding the live filesystem..."
du -sx --block-size=1 "$ROOTFS" | awk '{print $1}' > "$WORK/filesystem.size"
mksquashfs "$ROOTFS" "$WORK/filesystem.squashfs" -comp xz -b 1M -noappend -processors "$(nproc)"
# The rebuilt SquashFS is self-contained; remove the expanded tree before xorriso writes the ISO.
rm -rf "$ROOTFS"

awk '$2 != "./casper/filesystem.squashfs" && $2 != "./casper/filesystem.size" {print}' "$ISO_MOUNT/md5sum.txt" > "$WORK/md5sum.txt"
(
  cd "$WORK"
  md5sum filesystem.squashfs | sed 's|  filesystem.squashfs|  ./casper/filesystem.squashfs|'
  md5sum filesystem.size | sed 's|  filesystem.size|  ./casper/filesystem.size|'
) >> "$WORK/md5sum.txt"

echo "Rebuilding the bootable ISO while preserving the original UEFI/BIOS boot entries..."
xorriso \
  -indev "$BASE_ISO" \
  -outdev "$OUTPUT_ISO" \
  -map "$WORK/filesystem.squashfs" /casper/filesystem.squashfs \
  -map "$WORK/filesystem.size" /casper/filesystem.size \
  -map "$WORK/md5sum.txt" /md5sum.txt \
  -boot_image any replay \
  -compliance no_emul_toc \
  -padding included \
  -commit

[[ -s "$OUTPUT_ISO" ]] || {
  echo "ISO creation failed." >&2
  exit 1
}
xorriso -indev "$OUTPUT_ISO" -report_el_torito plain >/dev/null
sha256sum "$OUTPUT_ISO" > "${OUTPUT_ISO}.sha256"
BUILD_OK=1

echo
echo "Lumen ISO created: $OUTPUT_ISO"
echo "Checksum: ${OUTPUT_ISO}.sha256"
echo "This is a community remix based on Kubuntu 26.04.1; it is not signed by Ubuntu."
echo "Test it in a disposable UEFI virtual machine before writing USB media or installing."
