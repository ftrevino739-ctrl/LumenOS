# Build and install guide

## Current release state

Lumen 0.2 provides a buildable Qt 6 / QML desktop companion, C++ actions for opening approved system applications, a Plasma 6 style, Global Theme package, optional non-destructive panel template, color scheme, wallpaper and icon.

The Debian package is built, installed and smoke-tested by GitHub Actions. The separate live ISO builder is implemented but has not yet been run end-to-end or validated in a virtual machine. No certified Lumen ISO has been released.

## Download and install the Debian package

1. Open [GitHub Actions](https://github.com/ftrevino739-ctrl/LumenOS/actions).
2. Select the latest successful **Lumen build and validation** run.
3. Download the `lumen-desktop-deb` artifact and extract it.
4. On Kubuntu 26.04 with Plasma 6:

```bash
sudo apt install ./lumen-desktop-*.deb
lumen-desktop
```

The Actions artifact expires after 30 days.

## Install from source

Recommended host: Kubuntu 26.04 or Ubuntu with KDE Plasma 6. The installer checks for missing packages and asks before installing them.

```bash
git clone https://github.com/ftrevino739-ctrl/LumenOS.git
cd LumenOS
bash scripts/install.sh
```

Run as your normal user, never with sudo. The installer builds the app, installs it under `/usr/local`, and copies the Plasma style, Global Theme, optional panel template, color scheme and wallpaper to your user profile.

It does not format disks, replace the current Plasma shell, change the login manager or install an operating system.

## Activate Lumen appearance

- System Settings → Appearance → Global Theme → **Lumen**.
- Leave any desktop/panel layout replacement option unchecked to preserve existing panels.
- System Settings → Appearance → Plasma Style → **Lumen**.
- To add the optional panel: right-click the panel → Add Panel → **Lumen Glass Panel**. This is additive.
- Choose the Lumen wallpaper in Desktop and Wallpaper settings.

## Build manually

Requirements: Qt 6.4+, CMake 3.21+, C++17 compiler and Qt Quick runtime modules.

```bash
cmake -S desktop -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --parallel
./build/lumen-desktop
```

Build a Debian package:

```bash
cmake -S desktop -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr
cmake --build build --parallel
cpack --config build/CPackConfig.cmake -G DEB
```

## Build the live ISO

See [ISO build guide](ISO-BUILD.md). The script remasters the official Kubuntu 26.04.1 AMD64 live ISO and verifies its published SHA256 checksum before making changes.

It requires a Linux host, root access, xorriso, squashfs-tools, curl, chroot and at least 25 GiB free disk space. The output is an unsigned community remix and must be tested in a disposable UEFI virtual machine before any physical installation.

## Uninstall

Debian package:

```bash
sudo apt remove lumen-desktop
```

Source installation:

```bash
sudo rm -f /usr/local/bin/lumen-desktop
sudo rm -f /usr/local/share/applications/org.lumen.Desktop.desktop
sudo rm -f /usr/local/share/icons/hicolor/scalable/apps/lumen.svg
sudo rm -rf /usr/local/share/plasma/desktoptheme/lumen
sudo rm -rf /usr/local/share/plasma/look-and-feel/com.lumen.desktop
sudo rm -rf /usr/local/share/plasma/layout-templates/com.lumen.panel
sudo rm -f /usr/local/share/color-schemes/Lumen.colors
sudo rm -f /usr/local/share/backgrounds/lumen.svg
```

User appearance assets can be removed separately; see the uninstall section in the repository README.

## Safety

- Never run the source installer with sudo.
- Do not run an experimental ISO installer on a disk containing important data.
- Use a disposable VM and virtual disk for all ISO tests.
- Keep a backup and VM snapshot before changing desktop settings.
