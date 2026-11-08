# Build guide

## Current status

The repository contains a Qt Quick desktop-preview application. It has not yet been compiled or tested in a clean target environment. No VitreOS ISO has been built.

## Build the desktop preview

Requirements: Qt 6.6+ (Qt Quick and Qt Quick Controls), CMake 3.21+, and a C++17 compiler.

From the repository root:

```bash
cmake -S desktop -B build
cmake --build build
./build/vitreos-desktop
```

This is an ordinary user-space application. It does not need root privileges and does not replace the Plasma shell.

## Recommended future ISO build host

A clean Ubuntu 26.04 LTS amd64 VM with internet access and at least 30 GB free disk space. Take a VM snapshot before experimenting.

## Clone and inspect

```bash
git clone https://github.com/ftrevino739-ctrl/VitreOS.git
cd VitreOS
bash scripts/validate.sh
```

## Check package availability

After configuring APT sources for the intended Ubuntu release:

```bash
sudo apt update
scripts/check-packages.sh
```

The checker only reads package metadata; it does not install or remove packages.

## ISO pipeline

The ISO builder is intentionally not enabled until the supported Ubuntu 26.04 live-image tooling and installer integration are verified. Do not use an untested Debian live-build recipe and call the result an Ubuntu installer.

## Safety

- Test installation only in a disposable VM with a virtual disk.
- Never point an experimental installer at a physical disk.
- Review every privileged command before running it.
- Verify checksums of downloaded base images.
- Keep backups and VM snapshots.
