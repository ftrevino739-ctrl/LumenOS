# Build and install guide

## Current state

Lumen currently provides a Qt 6 / QML desktop application and a reversible installer for an existing Ubuntu/Kubuntu desktop. It is not yet a standalone bootable operating system and no installable Lumen ISO has been released.

## Recommended system

- Kubuntu 26.04 LTS with KDE Plasma 6, or Ubuntu with Plasma 6 installed.
- 64-bit x86 PC.
- Internet connection.
- User account with sudo permission.
- At least 2 GB free disk space for build dependencies and build output.

## Install the Lumen desktop application

Download the repository ZIP from GitHub or clone it, then run as your normal user:

```bash
git clone https://github.com/ftrevino739-ctrl/LumenOS.git
cd LumenOS
bash scripts/install.sh
```

The script asks before installing dependencies, compiles the Qt application, installs it under `/usr/local`, and installs the Lumen KDE color scheme for the current user. It does not format disks, replace Plasma, or alter the login manager.

After installation, find **Lumen Desktop Preview** in the application launcher or run `lumen-desktop`.

## Build without installing

Install CMake, a C++17 compiler, Qt 6 Quick and Qt 6 Quick Controls 2 development packages, then run:

```bash
cmake -S desktop -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --parallel
./build/lumen-desktop
```

## Uninstall

```bash
sudo rm -f /usr/local/bin/lumen-desktop /usr/local/share/applications/org.lumen.Desktop.desktop
rm -f ~/.local/share/color-schemes/Lumen.colors
```

## Future ISO work

A separate ISO pipeline still needs to be implemented and tested against the official Ubuntu 26.04 live-image and installer stack. Do not treat the desktop application installer as an operating-system installer. Any future ISO must first be tested in a disposable UEFI virtual machine with a virtual disk.

## Safety

- Do not run `scripts/install.sh` with sudo; it requests elevation only where needed.
- Review package installation prompts before accepting.
- Never point an experimental OS installer at a physical disk.
- Keep backups and VM snapshots.
