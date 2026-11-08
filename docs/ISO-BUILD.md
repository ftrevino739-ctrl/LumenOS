# Lumen live ISO build guide

## What this produces

The build script creates an unsigned community remix of the official Kubuntu 26.04.1 AMD64 desktop image. It installs the Lumen Debian package into the live root filesystem, sets the Lumen color scheme and Plasma style as defaults for newly created users, and preserves the original ISO boot records.

It does not replace Ubuntu/Kubuntu's kernel, package manager, Calamares installer or core services. The output is not an Ubuntu-official image.

## Requirements

- Ubuntu/Kubuntu Linux host with root access.
- At least 25 GiB free on the filesystem used for the output and temporary build.
- `xorriso`, `squashfs-tools`, `curl`, `chroot`, `mount`, `mksquashfs`, `unsquashfs`, `sha256sum`.
- Official `kubuntu-26.04.1-desktop-amd64.iso`.
- The `lumen-desktop-0.2.0-Linux.deb` artifact downloaded from GitHub Actions.

Install the host tools:

```bash
sudo apt update
sudo apt install xorriso squashfs-tools curl
```

Download the official ISO from [Kubuntu 26.04.1](https://cdimage.ubuntu.com/cdimage/kubuntu/releases/26.04.1/release/) and download the Lumen Debian artifact from [GitHub Actions](https://github.com/ftrevino739-ctrl/LumenOS/actions).

## Build

```bash
sudo bash scripts/build-iso.sh \
  /path/to/kubuntu-26.04.1-desktop-amd64.iso \
  /path/to/lumen-desktop-0.2.0-Linux.deb \
  /path/to/Lumen-26.04.1-amd64.iso
```

The script:

1. Checks the Kubuntu ISO against the official SHA256SUMS file.
2. Extracts the compressed live root filesystem.
3. Enters a temporary chroot and installs the Lumen Debian package using APT.
4. Sets the Lumen Plasma style and color scheme for new user profiles.
5. Rebuilds the SquashFS filesystem and updates its size and MD5 entries.
6. Uses xorriso to replace the live filesystem while replaying the original BIOS/UEFI boot configuration.
7. Writes a SHA-256 checksum next to the output ISO.

The script refuses to overwrite an existing output. If the build fails, it removes an incomplete output and cleans up temporary mounts and files.

## Required validation before release

Do not call the ISO installable until all of these checks pass:

- Boot the ISO in a clean UEFI virtual machine.
- Confirm the live Plasma session starts and the Lumen appearance loads.
- Open Lumen Desktop Preview, Dolphin, System Settings, terminal and browser.
- Connect to a network and run system updates.
- Install to a disposable virtual disk using the included Kubuntu installer.
- Reboot from the virtual disk and verify the installed system.
- Confirm the desktop remains usable after reboot and that recovery/updates work.

Do not test the first build on a physical disk. The remaster script has not yet been validated end-to-end, so expect to fix issues discovered during the first VM run.
