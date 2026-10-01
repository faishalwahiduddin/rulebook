# RuleBook — UI/UX Overhaul Master Checklist

> Owner: Senior UI/UX + Product + QA. Target: premium, clean, production-ready.
> Verification device: Android P10, 720x1600 @ density 2.0 (~360x800dp).

## Root-cause findings (Discovery)

| # | Finding | Impact | Severity |
|---|---------|--------|----------|
| 1 | **All 9 screens hardcode dark-mode colors** (`Colors.white` text, `0xFF94A3B8` grays, `AppColors.bgSurface`). Light mode is unusable: rule titles render pure white on white cards (verified: title rows are 100% `#FFFFFF`). | App broken in light mode | CRITICAL |
| 2 | **Navigation bypasses GoRouter.** Detail screens use `Navigator.push`/`pushReplacement` with raw `MaterialPageRoute`. Deep links, back-stack, and web URLs break. | Broken routing/web | HIGH |
| 3 | **Theme ignores design tokens.** No `textTheme`, no `ColorScheme` derivations; screens pick colors ad-hoc. | No visual consistency | HIGH |
| 4 | **Generic Material icon soup + emoji as content icons** (`💡`, `🛡️`, `📖`, `📋`, `✓`, `•`). Inconsistent stroke/fill; emoji fail cross-platform. | Cheap, "AI slop" look | HIGH |
| 5 | **Hardcoded Indonesian strings inside screens** (calculator details, validation errors, settings section headers) survive locale switches → mixed EN/ID UI. | i18n broken | HIGH |
| 6 | **Settings section headers hardcoded** ("Tampilan & Tema", "Mode Tema", "Bahasa & Lokalisasi"). | i18n broken | MED |
| 7 | **Contrast failures**: section headers `#ACB8C8` on `#F8FAFC` ≈ 2.0:1 (< 4.5:1). Secondary text `#94A3B8` on white ≈ 2.6:1. | WCAG AA fail | HIGH |
| 8 | **Localization default mismatch**: device shows English content but Indonesian chrome. Default locale logic vs. saved value. | Confusing first run | MED |
| 9 | **Bottom nav has 5 dense tabs** with long labels, crammed at 360dp. | Cramped nav | MED |
| 10 | **No onboarding / empty-state warmth.** Empty states are flat icon + two lines. | No activation | MED |
| 11 | **Calculator "tab" pills are not real tabs**; no result animation; heavy glow shadow on result card. | Dated feel | MED |
| 12 | **2 analyzer warnings** (unused imports). | Clean-build gate | LOW |
| 13 | **Emoji in snackbars** ("...📋"). | Unprofessional | LOW |

## Master Checklist (screens + key UI surfaces)

### Global
- [ ] **G1 — Design system & theme tokens**: rewrite `app_colors.dart` + `app_theme.dart` with semantic `ColorScheme`, `textTheme`, component themes (light + dark). Remove glow shadows. Fix contrast.
- [ ] **G2 — Custom icon set**: create `AppIcons` via `CustomPainter`/SVG-path widgets (gavel, shield, bookmark, catalog, calculator, checklist, traffic, scale). Replace emoji + generic Material in nav/headers.
- [ ] **G3 — Routing**: GoRouter routes for `/rule/:id`, `/sop/:id`, `/checklist/:id`; replace all `Navigator.push`.
- [ ] **G4 — i18n sweep**: move every hardcoded string to ARB; ensure all locales fall back cleanly.
- [ ] **G5 — Analyzer clean**: 0 warnings.

### Screens
- [ ] **S1 — Navigation shell** (`navigation_shell.dart`)
- [ ] **S2 — Catalog** (`catalog_screen.dart`) + search + quick chips + category chips + empty state
- [ ] **S3 — Rule detail** (`rule_detail_screen.dart`) + copy + bookmark + note form + related
- [ ] **S4 — Calculator** (`penalty_calculator_screen.dart`) 5 tabs + validation + result cards
- [ ] **S5 — SOP list** (`sop_screen.dart`)
- [ ] **S6 — SOP detail** (`sop_detail_screen.dart`) + steps timeline + hotlines
- [ ] **S7 — Checklist list** (`checklist_screen.dart`) + progress
- [ ] **S8 — Checklist detail** (`checklist_detail_screen.dart`) + reset dialog
- [ ] **S9 — Bookmarks & notes** (`bookmarks_screen.dart`) + segments + empties
- [ ] **S10 — Settings** (`settings_screen.dart`) + theme + language modal + data + about
- [ ] **Modals/Dialogs**: language bottom sheet, reset checklist dialog, delete-data dialog.

## Scoring rubric (per screen, 0-100)
- Visual (hierarchy, spacing, type, icons, no gradient/shadow slop): 40
- UX & humanized copy (states, clarity, warmth, i18n correctness): 30
- Functionality (all interactions work, no crash, validation): 30
