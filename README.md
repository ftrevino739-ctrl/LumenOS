# Lumen

**A modern Ubuntu-based Linux desktop with an original Liquid Glass identity.**

Lumen is an independent distribution project built around KDE Plasma 6, Qt 6 / QML and a carefully designed translucent desktop experience.

> **Status: early development.** The repository now includes a runnable Qt Quick desktop-preview application and initial Plasma branding. It has not yet been built in this environment, integrated as a Plasma shell, packaged into an ISO, or validated in a virtual machine.

## Product direction

- **Base:** Ubuntu 26.04 LTS, using the Kubuntu/KDE Plasma desktop foundation.
- **Desktop:** KDE Plasma 6; Wayland preferred.
- **Toolkit:** Qt 6 and QML for original Lumen components.
- **Visual identity:** translucent surfaces, subtle blur, fine highlights, soft depth, rounded geometry and accessible contrast.
- **Initial target:** amd64 live image with a working installer, followed by VM and hardware validation.

Ubuntu is selected to keep the system approachable and reduce base-system maintenance. Lumen customizes the desktop instead of replacing the Linux kernel, package manager or core KDE services.

## Repository map

- `desktop/` — Qt Quick preview application and reusable QML components.
- `docs/ARCHITECTURE.md` — system architecture and release acceptance criteria.
- `docs/DESIGN-SYSTEM.md` — Liquid Glass visual language and design tokens.
- `docs/BUILD.md` — development workflow and safety requirements.
- `config/packages/base.txt` — initial package targets; availability must be checked.
- `config/plasma/Lumen.colors` — initial KDE color scheme.
- `scripts/` — validation, package-checking and build helpers.
- `.github/workflows/validate.yml` — repository validation.

## Build the desktop preview

Requirements: Qt 6.6+, CMake 3.21+, and a C++17 compiler.

```bash
cmake -S desktop -B build
cmake --build build
./build/lumen-desktop
```

See [desktop/README.md](desktop/README.md) and [docs/BUILD.md](docs/BUILD.md).

## Development milestones

1. Establish the visual identity and baseline Plasma configuration.
2. Build and test the Qt Quick desktop preview.
3. Integrate the design with real Plasma components and session configuration.
4. Build a customized live desktop from verified Ubuntu 26.04 tooling.
5. Integrate and validate the installer.
6. Test boot, install, reboot, networking, graphics, updates and recovery in a disposable VM.
7. Publish a release only after acceptance checks pass.

## Safety and scope

Do not install experimental images on a machine containing important data. Use a disposable virtual machine and virtual disk until the installer is proven. Lumen v0.1 does not promise universal hardware support or replace Windows/macOS.

## License

MIT. See [LICENSE](LICENSE).
