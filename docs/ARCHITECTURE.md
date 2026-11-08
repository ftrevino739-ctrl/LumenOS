# VitreOS architecture

## Product direction
VitreOS is an Ubuntu-based desktop distribution with KDE Plasma 6 and an original Liquid Glass visual identity. The first release target is a reproducible amd64 live image that installs to a virtual disk and boots into a functional desktop.

## Stack
- Base: Ubuntu 26.04 LTS (Kubuntu desktop foundation).
- Desktop: KDE Plasma 6; Wayland preferred, fallback determined by supported packages.
- UI: Qt 6 and QML for original utilities and shell components.
- Styling: Plasma 6-compatible theme, color scheme, icons, wallpaper and window decoration.
- Automation: Bash and Python.

## Principles
1. Prefer upstream Ubuntu and KDE components over replacing core system services.
2. Keep customization reversible and upgrades maintainable.
3. Maintain readable contrast and keyboard accessibility on all glass surfaces.
4. Build in stages and verify each artifact; never label an untested ISO as installable.
5. Do not implement a custom kernel or package manager for the first release.

## ISO acceptance criteria
A release candidate must boot in a clean UEFI virtual machine, provide a live Plasma session, complete installation to a disposable virtual disk, reboot from that disk, connect to a network, launch core applications, and apply updates. Hardware support claims require separate testing.

## Initial target
- Architecture: amd64 / x86_64.
- Firmware: UEFI first.
- Graphics: Mesa-supported hardware initially.
- Session: Plasma Wayland preferred.

## Out of scope for v0.1
Custom kernel, universal hardware support, full Windows/macOS replacement, unattended disk formatting, and an entirely new desktop shell.