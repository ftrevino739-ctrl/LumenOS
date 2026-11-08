# VitreOS Liquid Glass design system

## Direction
A calm, premium glass interface: layered translucent surfaces, subtle background blur, fine edge highlights, soft shadows, rounded geometry and restrained motion. It must remain a usable desktop, not a static concept.

## Initial tokens
| Token | Value | Use |
|---|---|---|
| Accent | #8BCBFF | Primary actions and focus |
| Accent deep | #477FBA | Hover and selected states |
| Text primary | #F4F7FC | Main text on dark glass |
| Text secondary | #C2CCDA | Supporting text |
| Glass surface | rgba(24,34,50,0.62) | Floating surfaces |
| Glass elevated | rgba(38,51,72,0.76) | Menus and dialogs |
| Glass border | rgba(255,255,255,0.18) | Surface edge |
| Radius small | 10px | Compact controls |
| Radius medium | 16px | Cards and menus |
| Radius large | 24px | Panels |

These are initial design tokens, not certified contrast values.

## Rules
- Keep blur restrained; avoid expensive full-screen effects.
- Always provide visible keyboard focus.
- Provide opaque fallbacks when compositing is unavailable.
- Respect reduced-motion preferences.
- Never communicate state by color alone.
- Preserve legibility over wallpapers and variable backgrounds.
- Use original or properly licensed assets.

## First visual milestone
Customize the Plasma color scheme, wallpaper, panel layout, launcher and window decoration before building a custom shell. Validate at common laptop resolutions and with keyboard navigation.