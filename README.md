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
