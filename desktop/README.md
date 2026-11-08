# Lumen desktop preview

This directory contains the first runnable Qt 6 / QML application prototype. It is an application preview that runs on top of KDE Plasma; it does **not** replace Plasma's shell or provide a complete desktop session yet.

## Build

Requirements: Qt 6.6+ with the Qt Quick development components, CMake 3.21+, and a C++17 compiler.

```bash
cmake -S desktop -B build
cmake --build build
./build/lumen-desktop
```

The application uses Qt Quick Controls' Basic style and bundled QML components. It does not require elevated privileges.

## Current limitations

- Navigation changes the preview content label; the destinations are not full applications.
- Translucent surfaces are simulated with alpha colors. Real background blur depends on the KDE compositor and will be integrated in a later step.
- This is not yet a Plasma shell, login session, installer, or bootable ISO.
