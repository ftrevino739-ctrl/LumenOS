# Lumen Liquid Glass design system

## Direction

A calm, premium glass interface: layered translucent surfaces, restrained background blur, fine edge highlights, soft depth, rounded geometry and purposeful motion. Lumen must remain a usable desktop rather than a static concept.

## Tokens

| Token | Value | Use |
|---|---|---|
| Accent | #8BCBFF | Primary actions and focus |
| Accent deep | #477FBA | Selected states |
| Text primary | #F4F7FC | Main text on dark glass |
| Text secondary | #C2CCDA | Supporting text |
| Glass surface | rgba(24,34,50,0.62) | Floating surfaces |
| Glass elevated | rgba(38,51,72,0.76) | Menus and dialogs |
| Glass border | rgba(255,255,255,0.18) | Surface edge |
| Radius small | 10px | Compact controls |
| Radius medium | 16px | Cards and menus |
| Radius large | 24px | Panels |

These are initial design tokens, not certified contrast values.

## Implemented assets

- `desktop/GlassSurface.qml`: reusable translucent QML surface with adjustable fill, border and corner radius.
- `config/plasma/desktoptheme/lumen/`: Plasma 6 panel, widget and dialog SVG frames with a dark blue glass treatment.
- `config/plasma/Lumen.colors`: KDE color scheme.
- `config/plasma/look-and-feel/com.lumen.desktop/`: Global Theme defaults for Lumen colors and Plasma style.
- `config/plasma/layout-templates/com.lumen.panel/`: optional additive panel layout.
- `config/wallpapers/lumen.svg`: original 2560×1440 gradient wallpaper.
- `config/icons/lumen.svg`: scalable application icon.

## Rules

- Keep blur restrained; do not require expensive full-screen effects.
- Always provide visible keyboard focus.
- Provide opaque fallbacks when compositing is unavailable.
- Respect reduced-motion preferences.
- Never communicate state by color alone.
- Preserve legibility over wallpapers and variable backgrounds.
- Use original or properly licensed assets.
- Never reset an existing user's panel layout as an automatic install action.

## Next visual milestone

Test the Plasma style in a real Plasma 6 session, then add a tested KWin window decoration and SDDM theme as separate, reversible packages. Do not ship them as active defaults until the fallback and recovery path is verified.
