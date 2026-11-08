# Lumen architecture

## Product direction

Lumen is a Kubuntu/Ubuntu-based desktop distribution project with an original Liquid Glass identity. The first deliverable is a usable Plasma 6 desktop layer and a reproducible AMD64 live image that can be installed to a virtual disk.

Lumen intentionally reuses Ubuntu's kernel, APT package management, Plasma session, display manager and Calamares installer. The project is not a new kernel or a fork of the Linux kernel.

## Current implementation

- Qt 6 / QML desktop companion with C++ system actions.
- Plasma 6 desktop style under `/usr/share/plasma/desktoptheme/lumen`.
- Global Theme package under `/usr/share/plasma/look-and-feel/com.lumen.desktop`.
- Additive panel template under `/usr/share/plasma/layout-templates/com.lumen.panel`.
- Lumen color scheme, wallpaper and icon.
- Debian package generated and installed by CI.
- Live ISO remaster script based on the official Kubuntu 26.04.1 AMD64 desktop image. The script is not yet validated end-to-end.

## Stack

- Base: Kubuntu 26.04.1 LTS.
- Desktop: KDE Plasma 6; Wayland preferred, X11 only where the base image supports it.
- UI: Qt 6, QML and C++17.
- Automation: Bash and Python.
- Packaging: CMake / CPack DEB.
- Live media: original Kubuntu casper filesystem, SquashFS and xorriso boot-image replay.

## Design and safety principles

1. Prefer upstream Ubuntu and KDE components over replacing core system services.
2. Keep desktop changes reversible and upgrades maintainable.
3. Maintain readable contrast and keyboard accessibility on glass surfaces.
4. Never delete or overwrite a user's existing Plasma panel as an automatic side effect.
5. Build and verify each artifact; never label an untested ISO as installable.
6. Do not implement a custom kernel or package manager for the first release.

## ISO acceptance criteria

A release candidate must:
- Boot in a clean UEFI virtual machine.
- Provide a live Plasma session with the Lumen appearance.
- Launch Lumen, Dolphin, System Settings, a terminal and a browser.
- Connect to a network and apply system updates.
- Complete installation to a disposable virtual disk using the included Kubuntu installer.
- Reboot from the installed virtual disk and remain functional.
- Preserve a working recovery/update path.

Hardware compatibility claims require separate testing on physical hardware.

## Initial target

- Architecture: amd64 / x86_64.
- Firmware: UEFI first; BIOS compatibility inherited from the base ISO and must be verified.
- Graphics: Mesa-supported hardware initially.
- Session: Plasma Wayland preferred.

## Out of scope for the first release

Custom kernel, custom package manager, universal hardware support, a new installer, automatic disk formatting, and replacing Plasma with an entirely new shell.
