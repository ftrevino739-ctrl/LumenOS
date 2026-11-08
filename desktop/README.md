# VitreOS desktop components

This directory contains original Qt 6 / QML components used by VitreOS-specific desktop utilities.

## GlassSurface.qml

A small reusable translucent surface with configurable fill, edge and corner radius. It deliberately does not implement blur itself: background blur and translucency should be coordinated with KDE Plasma/KWin compositor settings to avoid expensive nested effects and inconsistent behavior.

## Development requirements

Use Qt 6 and QML APIs available in the target Ubuntu release. Components must support keyboard focus when interactive, preserve readable contrast, and provide a solid-surface fallback when transparency/compositing is disabled.

This is an initial component library, not a replacement Plasma shell.