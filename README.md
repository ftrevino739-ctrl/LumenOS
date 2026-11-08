# Lumen

**An Ubuntu/Kubuntu-based desktop project with a Liquid Glass identity.**

Lumen is an independent Linux desktop project built on Ubuntu 26.04 LTS, KDE Plasma 6, Qt 6 and QML. It customizes the existing Linux desktop rather than replacing the kernel, package manager or core KDE services.

> **Development status:** Lumen now has a Qt Quick desktop companion with real system actions, a KDE Plasma 6 style, a Global Theme package, a non-destructive optional panel template, a color scheme, an original wallpaper and a CI-built Debian package. The bootable ISO builder is implemented but has not yet been run and VM-tested. Do not treat the current Debian package as an operating-system installer.

## Current features

- Liquid Glass-inspired Lumen desktop companion.
- Opens the home folder, System Settings, a terminal and the default web browser.
- Launches allow-listed desktop applications (Dolphin, Firefox, Discover, Konsole).
- Displays system, kernel and architecture information.
- KDE Plasma 6 color scheme and desktop style.
- Plasma Global Theme package with appearance defaults.
- Optional "Lumen Glass Panel" layout template. Adding it does not delete existing panels.
- Original Lumen SVG wallpaper and application icon.
- Debian package built and smoke-tested by GitHub Actions.

## Target platform

- **Base:** Kubuntu 26.04.1 LTS, AMD64.
- **Desktop:** KDE Plasma 6.
- **Toolkit:** Qt 6 / QML, C++17.
- **Visual language:** translucent surfaces, restrained blur, edge highlights, rounded geometry and readable contrast.
- **Initial hardware target:** 64-bit x86 PC; UEFI boot first.

Lumen is a desktop customization layer over Ubuntu/Kubuntu. It does not use a custom kernel or package manager.

## Download the desktop package

1. Open [Lumen GitHub Actions](https://github.com/ftrevino739-ctrl/LumenOS/actions).
2. Open the latest successful **Lumen build and validation** run.
3. Under **Artifacts**, download `lumen-desktop-deb` and extract the ZIP.
4. On Kubuntu 26.04 with KDE Plasma 6, install the package:

   ```bash
   sudo apt install ./lumen-desktop-*.deb
   ```

5. Launch **Lumen Desktop Preview** from the application menu or run:

   ```bash
   lumen-desktop
   ```

The package includes the desktop companion, Plasma style, Global Theme, optional panel template, color scheme, wallpaper and icon. GitHub Actions artifacts are temporary and expire after 30 days.

## Install from source

On Kubuntu 26.04 or an Ubuntu installation with KDE Plasma 6:

```bash
git clone https://github.com/ftrevino739-ctrl/LumenOS.git
cd LumenOS
bash scripts/install.sh
```

Run the script as your normal user, **not with sudo**. It asks before installing missing build/runtime dependencies and uses sudo only for system installation.

The script installs the application under `/usr/local` and copies the appearance assets into your user profile. It does not repartition disks, replace Plasma, change the login manager or install an operating system.

## Activate the appearance

After installing the package or source tree:

1. Open **System Settings → Appearance → Global Theme** and select **Lumen**.
2. If selecting a global theme offers a desktop/panel layout option, leave that option unchecked to preserve your current panels.
3. To add the optional panel, right-click your existing panel → **Add Panel → Lumen Glass Panel**. This creates an additional panel; it does not erase the current one.
4. Choose **Lumen** under **System Settings → Appearance → Plasma Style** if it is not already active.
5. Choose `/usr/share/backgrounds/lumen.svg` (package install) or `~/Pictures/Wallpapers/Lumen.svg` (source install) in Desktop and Wallpaper settings.

## Build manually

Requirements: Qt 6.4+, CMake 3.21+, a C++17 compiler and the Qt Quick / Quick Controls 2 QML runtime modules.

```bash
cmake -S desktop -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --parallel
./build/lumen-desktop
```

To create a Debian package:

```bash
cmake -S desktop -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr
cmake --build build --parallel
cpack --config build/CPackConfig.cmake -G DEB
```

## Build the bootable Lumen ISO

The repository includes `scripts/build-iso.sh`. It remasters the official Kubuntu 26.04.1 AMD64 live image, installs the Lumen Debian package into the live filesystem, sets safe Plasma defaults for newly created users, preserves the original boot records, and emits a SHA-256 checksum.

Official base image: [Kubuntu 26.04.1 download and checksums](https://cdimage.ubuntu.com/cdimage/kubuntu/releases/26.04.1/release/).

Requirements:
- A real Ubuntu/Kubuntu Linux host with root access.
- `xorriso`, `squashfs-tools`, `curl`, `chroot` and standard system utilities.
- At least **25 GiB free space** on the output filesystem.
- The official `kubuntu-26.04.1-desktop-amd64.iso`.
- The Lumen `.deb` downloaded from GitHub Actions.

Run:

```bash
sudo bash scripts/build-iso.sh \
  /path/to/kubuntu-26.04.1-desktop-amd64.iso \
  /path/to/lumen-desktop-0.2.0-Linux.deb \
  /path/to/Lumen-26.04.1-amd64.iso
```

The script checks the base ISO against Kubuntu's published SHA256SUMS before modifying it. The output is a community remix, not an Ubuntu-signed image. The build script is not yet certified by a successful end-to-end ISO build; test the resulting image in a disposable UEFI virtual machine before using USB media or installing to a physical disk.

## Uninstall

For the Debian package:

```bash
sudo apt remove lumen-desktop
```

For a source installation under `/usr/local`:

```bash
sudo rm -f /usr/local/bin/lumen-desktop
sudo rm -f /usr/local/share/applications/org.lumen.Desktop.desktop
sudo rm -f /usr/local/share/icons/hicolor/scalable/apps/lumen.svg
sudo rm -rf /usr/local/share/plasma/desktoptheme/lumen
sudo rm -rf /usr/local/share/plasma/look-and-feel/com.lumen.desktop
sudo rm -rf /usr/local/share/plasma/layout-templates/com.lumen.panel
sudo rm -f /usr/local/share/color-schemes/Lumen.colors
sudo rm -f /usr/local/share/backgrounds/lumen.svg
rm -rf ~/.local/share/plasma/desktoptheme/lumen
rm -rf ~/.local/share/plasma/look-and-feel/com.lumen.desktop
rm -rf ~/.local/share/plasma/layout-templates/com.lumen.panel
rm -f ~/.local/share/color-schemes/Lumen.colors
rm -f ~/Pictures/Wallpapers/Lumen.svg
```

If you activated the Lumen Plasma style or color scheme, select Breeze (or another installed theme) in System Settings before removing the assets.

## Repository map

- `desktop/` — Qt Quick application and C++ system actions.
- `config/plasma/desktoptheme/` — Plasma 6 style assets.
- `config/plasma/look-and-feel/` — Global Theme package.
- `config/plasma/layout-templates/` — optional panel layout.
- `config/wallpapers/` and `config/icons/` — original Lumen assets.
- `scripts/install.sh` — reversible source installer.
- `scripts/install-theme.sh` — per-user appearance installer.
- `scripts/build-iso.sh` — Kubuntu live-image remaster script.
- `.github/workflows/validate.yml` — build, Debian package install and Qt Quick smoke test.

## Safety and release policy

- The source installer does not modify partitions, bootloaders or login managers.
- The optional panel is additive; it does not replace existing panels.
- The ISO builder modifies only a temporary extracted copy of the live filesystem and writes a new ISO. It refuses to overwrite an existing output file.
- Do not install an untested ISO on a computer containing important data.
- A release ISO must boot in a clean UEFI virtual machine, complete installation to a disposable virtual disk, reboot, connect to a network, launch core apps and apply updates before being called installable.

## License

MIT. See [LICENSE](LICENSE).
