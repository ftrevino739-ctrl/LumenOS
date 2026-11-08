# VitreOS

**A modern Ubuntu-based Linux desktop with an original Liquid Glass identity.**

VitreOS is an independent distribution project built around KDE Plasma 6, Qt 6 / QML and a carefully designed translucent desktop experience.

> **Status: early development.** The repository contains the initial architecture, design tokens, package targets and starter desktop assets. No installable VitreOS ISO has been built or validated yet.

## Product direction

- **Base:** Ubuntu 26.04 LTS, using the Kubuntu/KDE Plasma desktop foundation.
- **Desktop:** KDE Plasma 6; Wayland preferred.
- **Toolkit:** Qt 6 and QML for original VitreOS components.
- **Visual identity:** translucent surfaces, subtle blur, fine highlights, soft depth, rounded geometry and accessible contrast.
- **Initial target:** amd64 live image with a working installer, followed by VM and hardware validation.

Ubuntu is selected to keep the system approachable and reduce base-system maintenance. VitreOS customizes the desktop instead of replacing the Linux kernel, package manager or core KDE services.

## Repository

- `docs/ARCHITECTURE.md` — system architecture and release acceptance criteria.
- `docs/DESIGN-SYSTEM.md` — Liquid Glass visual language and design tokens.
- `docs/BUILD.md` — development workflow and safety requirements.
- `config/packages/base.txt` — initial package targets; availability must be checked.
- `config/plasma/VitreOS.colors` — initial KDE color scheme.
- `desktop/components/GlassSurface.qml` — reusable translucent QML surface.
- `scripts/` — validation and package-checking helpers.
- `.github/workflows/validate.yml` — CI validation.

## Development milestones

1. Establish the visual identity and baseline Plasma configuration.
2. Build a customized live desktop from verified Ubuntu 26.04 tooling.
3. Integrate and validate the installer.
4. Test boot, install, reboot, networking, graphics, updates and recovery in a disposable VM.
5. Publish a release only after acceptance checks pass.

## Getting started

```bash
git clone https://github.com/ftrevino739-ctrl/VitreOS.git
cd VitreOS
bash scripts/validate.sh
```

See [docs/BUILD.md](docs/BUILD.md) before attempting image creation.

## Safety and scope

Do not install experimental images on a machine containing important data. Use a disposable virtual machine and virtual disk until the installer is proven. VitreOS v0.1 does not promise universal hardware support or replace Windows/macOS.

## License

MIT. See [LICENSE](LICENSE).
