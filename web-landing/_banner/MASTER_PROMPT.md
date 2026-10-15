# Banner master prompt — RuleBook

Use this as the **system / style lock** for every blog banner for `rulebook`.
Fill the ARTICLE block per package, then paste into Gemini Images (or any image model).

## Brand tokens (from `web-landing/style.css`)

| Token | Value |
|-------|-------|
| primary | `#C2410C` |
| secondary | `#FB923C` |
| accent | `#FED7AA` |
| bg_dark | `#1E0D04` |
| accent_rgb | `254, 215, 170` |
| subdomain | `rulebook.faishal.id` |

## Visual system (matches fleet Chrome banners)

Existing fleet banners are **1200×675** editorial cards:

- Dark atmospheric base (`bg_dark`) with soft radial glows using `accent` / `primary`
- Subtle grid pattern at low opacity (`rgba(accent_rgb, ~0.05)`)
- Left: badge + bold title + short description + footer `rulebook.faishal.id · Offline-first · Privasi Terjaga`
- Right: glassmorphism “product card” (blurred panel, thin accent border, progress/checklist motif)
- Typography feel: Plus Jakarta Sans weight 800 titles, clean sans UI chrome (illustrated, not a real screenshot)
- No cluttered text walls; title may appear in the image sparingly or not at all if the model adds noise

Domain mood for `rulebook`: **sharp operator clarity, grid + progress, restrained accent color**
Motifs: kanban columns, milestones, seals/stamps, portfolio frames, habit rings
Avoid: purple SaaS gradients, 3D rocket clichés, crypto neon

## Master prompt (copy below)

```text
Editorial blog hero image, exactly 1200x675, 16:9, ultra-clean product marketing still.

Brand: RuleBook (rulebook.faishal.id).
Color script: background #1E0D04, primary #C2410C, secondary #FB923C, accent #FED7AA. Soft radial glows and a faint technical grid. Glassmorphism card on the right with accent border.

Mood: sharp operator clarity, grid + progress, restrained accent color.
Motifs: kanban columns, milestones, seals/stamps, portfolio frames, habit rings.
Style lock: dark premium editorial, offline-first privacy apps by faishal.id, no stock-photo people faces, no real phone UI screenshot, no watermark, no busy typography, no purple SaaS gradient cliché.

Composition: left negative space for title overlay OR minimal elegant title; right a single frosted glass info card suggesting the article topic with progress bars / checklist / compass / journal fields as abstract UI (illustrated).

ARTICLE TOPIC: {{ARTICLE_TITLE}}
ARTICLE ANGLE: {{IDEA_TYPE}} — keyword {{KEYWORD}}
ONE-LINE SCENE: {{SCENE_HINT}}

Output: single image, sharp, high contrast, ready as og:image / blog banner.
```

## Article fill-in rules

1. `ARTICLE_TITLE` = Indonesian H1 (or English if generating EN-only creative).
2. `IDEA_TYPE` = how-to | glossary | checklist | comparison | persona.
3. `KEYWORD` = primary SEO keyword from schedule TSV.
4. `SCENE_HINT` = one concrete noun phrase (e.g. “weekly amal review checklist on a dark glass card”).
5. Keep text inside the image minimal; HTML page already carries the real title.
6. Export JPEG 1200×675 (crop with `sips` if the model returns another size).
7. Save as `_queue/{package_id}/banner.jpg` then promote/inject.

## Fallback (no Gemini)

Use fleet Chrome renderer:

```bash
python3 tools/generate_all_article_banners.py --queue rulebook
```

That path rebuilds the same glass-card layout from CSS tokens without an external image model.
