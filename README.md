# Lumen

**A modern Ubuntu-based Linux desktop with an original Liquid Glass identity.**

Lumen is an independent desktop-distribution project built around KDE Plasma 6, Qt 6 / QML and a carefully designed translucent desktop experience.

> **Status: early development.** This repository contains the Lumen Qt Quick desktop application, an installer for that application on an existing Ubuntu/Kubuntu system, and initial Plasma branding. It is not yet a standalone operating system or bootable ISO.

## Product direction

- **Base target:** Ubuntu 26.04 LTS with KDE Plasma 6 (Kubuntu foundation).
- **Desktop:** KDE Plasma 6; Wayland preferred.
- **Toolkit:** Qt 6 and QML.
- **Visual identity:** translucent surfaces, subtle blur, fine highlights, soft depth, rounded geometry and accessible contrast.
- **First usable milestone:** installable Lumen desktop application on an existing Kubuntu/Plasma system.

Lumen customizes the Linux desktop instead of replacing the kernel, package manager or core KDE services. This keeps the first version maintainable and reversible.

## Install Lumen Desktop

Recommended: Kubuntu 26.04 LTS (or a supported Ubuntu installation with KDE Plasma 6), an internet connection, and a user account with sudo permission.

1. Open the repository page and choose **Code → Download ZIP**, or clone it:
   ```bash
   git clone https://github.com/ftrevino739-ctrl/Lumen.git
   cd Lumen
   ```
2. Run the interactive installer as your normal user (do not prefix it with sudo):
   ```bash
   bash scripts/install.sh
   ```
3. Confirm the dependency installation when prompted. The script builds and installs the Lumen app and applies the Lumen color scheme for your user.
4. Open the application launcher and search for **Lumen Desktop Preview**, or run:
   ```bash
   lumen-desktop
   ```

The installer uses sudo for APT dependencies and installing the app under `/usr/local`. It does not repartition disks, replace Plasma, change the login manager, or install an operating system.

## Uninstall

Remove the installed application and launcher:
```bash
sudo rm -f /usr/local/bin/lumen-desktop /usr/local/share/applications/org.lumen.Desktop.desktop
rm -f ~/.local/share/color-schemes/Lumen.colors
``

## Repository map

- `desktop/` — Qt Quick application and reusable QML components.
- `docs/ARCHITECTURE.md` — architecture and future release acceptance criteria.
- `docs/DESIGN-SYSTEM.md` — Liquid Glass visual language and design tokens.
- `docs/BUILD.md` — build workflow and safety requirements.
- `config/packages/base.txt` — initial package targets, not an install manifest.
- `config/plasma/Lumen.colors` — KDE color scheme.
- `scripts/install.sh` — interactive application installer.
- `scripts/install-theme.sh` — per-user theme installer.
- `.github/workflows/validate.yml` — repository validation and Qt build.

## Build manually

Requirements: Qt 6.4+, CMake 3.21+, and a C++17 compiler.

```bash
cmake -S desktop -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --parallel
./build/lumen-desktop
```

## Roadmap

1. Keep the Qt desktop application buildable and testable.
2. Add a real Plasma 6 theme package and reversible desktop layout.
3. Integrate original wallpaper, icons, window decoration and panel styling.
4. Establish a reproducible Ubuntu 26.04 live-image and installer pipeline.
5. Test boot, installation, reboot, networking, graphics, updates and recovery in a disposable VM.
6. Publish an ISO only after those acceptance checks pass.

## Safety and scope

Lumen is currently an application and desktop customization layer, not an independent operating system. Do not install future experimental images on a machine containing important data. Use a disposable virtual machine and virtual disk until an installer has been fully validated.

## License

MIT. See [LICENSE](LICENSE).
