# Design Audit — RuleBook

**Date:** 2026-11-20 · **Version:** 1.1.1+18 · **Grade: 61.5 / 100 — D**
**Mode:** deep (all 11 screens + shared widgets + token files + real renders + measured contrast)
**Reviewer stance:** senior mobile designer. Grades are earned; a working-but-unassembled screen is a C.

> **Read the grade correctly.** Craft-wise this is the strongest shell in the fleet: real semantic
> tokens, 0 hardcoded colours in all 9 product screens, a dark-mode contrast test over 9 routes, real
> empty states, haptics. What holds it at **D** is trust, not polish: the app **never dates its own
> content**, **search cannot find what the user reads** in 7 of 8 locales, and the **light theme
> breaks the app's own 4.5:1 clause** while the test only runs in dark.

## 1. Snapshot

| Field | Value |
|---|---|
| Product | RuleBook — pocket rules, regulations, SOPs; offline reference for law, labour, privacy, consumer, safety, ethics |
| Version | `1.1.1+18` (`pubspec.yaml:7`) |
| Platform | Flutter 3.44.8 · Android + iOS + Web (`rulebook.faishal.id`) · Material 3 · light + dark |
| Dart files | 71 (`lib/`) |
| Routes / screens | 11 routes / 11 screens (3 of them built inline by their parent route) + 1 missing-content fallback |
| Router | `lib/core/router/app_router.dart` — `StatefulShellRoute.indexedStack`, 5 branches, `/settings` on root navigator |
| State / content | Riverpod 3; all content compile-time `const` in `lib/core/storage/rules_database.dart` (`:7`) — 31 rules · 5 SOPs · 4 checklists · 6 ITE entries · 5 calculators |
| Locales | 8 (`id, en, ar, es, ja, jv, su, zh`) — every rule has a translated title/summary/penalty/explanation/Dos/Donts, asserted by `test/rule_localization_test.dart:47-60` |
| Design tokens | `lib/core/theme/{app_colors,app_theme,app_motion,app_icons}.dart` — **4 of 12** fleet token files (T3), debt index 45.2; SSOT docs at `docs/reference/design-system/` |
| Test rigour | 21 test files incl. dark-mode contrast scan over 9 routes, landscape suite at 5 viewports, overflow harness, store-render generator — **above fleet average** |

**The two numbers that matter.**

1. `docs/reference/design-system/components.md:41` states:
   > *"**Dilarang** menulis `Color(0x...)` literal langsung di widget presentation."*

   Measured (`grep -o "Color(0x"`): **121 total**, split below. The ban is genuinely respected in
   product screens — which is why the failures that remain are structural, not cosmetic.

| Layer | `Color(0x…)` | Verdict |
|---|---:|---|
| `lib/features/` (screens/widgets) | **26** | all 26 inside `rulebook_share_dialog.dart` (export canvas: 4 themes × fixed brand gradients) |
| `lib/core/theme/` | **62** | legal — token definitions (`app_colors.dart` 58, `app_theme.dart` 2, `app_icons.dart` 1) |
| `lib/core/constants/app_colors.dart` | **17** | **dead file** — 0 imports (see §10) |
| `lib/core/ui/` | **16** | splash 5, onboarding 5, `fleet_app_config.dart` 3 |
| **Product screens with one inline hex** | **0 / 9** | credit: the family-wide failure mode is absent here (the 26 live in one share-canvas widget) |

2. `docs/reference/design-system/foundations.md:111` states: *"Kontras teks minimal WCAG AA 4.5:1 di
   kedua tema (DS-6)."* Measured on the shipped light palette, three of six category accents fail as
   text at 10.5sp on white — traffic **4.10**, labor **3.77**, consumer **3.19** — and a fourth
   (ethics, 4.39) fails on the page background. The dark variants all pass 6.4–10.7.
   `test/trace/dark_contrast_test.dart:22` sets `theme_mode: 'dark'` — the guard tests the theme that
   passes and skips the one that fails.

## 2. Sitemap

Generated from `lib/core/router/app_router.dart` (11 `GoRoute` nodes; production tree below).

```
/splash                        → FleetSplashScreen        core/ui/fleet_splash_screen.dart (294 LOC)
/onboarding                    → FleetOnboardingScreen    core/ui/fleet_onboarding_screen.dart (1002)
/            (shell · branch 1) → CatalogScreen            features/catalog/catalog_screen.dart (409)
└─ /rule/:id                   → RuleDetailScreen         features/catalog/rule_detail_screen.dart (416)
/calculator  (shell · branch 2) → PenaltyCalculatorScreen  features/calculator/penalty_calculator_screen.dart (1220)
/sop         (shell · branch 3) → SopScreen                features/sop/sop_screen.dart (269)
└─ /sop/:id                    → SopDetailScreen          features/sop/sop_detail_screen.dart (324)
/checklist   (shell · branch 4) → ChecklistScreen          features/checklist/checklist_screen.dart (304)
└─ /checklist/:id              → ChecklistDetailScreen    features/checklist/checklist_detail_screen.dart (239)
/bookmarks   (shell · branch 5) → BookmarksScreen          features/bookmarks/bookmarks_screen.dart (418)
/settings    (root navigator)   → SettingsScreen           features/settings/settings_screen.dart (659)
```

Structural notes:

- **Shell is correct.** `indexedStack` (`app_router.dart:52-137`) gives each branch its own navigator,
  so a rule you were reading survives a trip to the calculator. Tapping the active tab resets to its
  root (`navigation_shell.dart:19-24`) — standard iOS/Android behaviour.
- **Detail routes are pushed on the root navigator** (`app_router.dart:63-73, 92-102, 113-123`). Full-screen
  push, platform transition, back gesture — correct. Settings sits outside the shell (`:138-142`),
  also correct.
- **Deep links exist and are safe.** `/rule/<id>` resolves against the local DB and falls back to a
  designed `_MissingContentScreen` with a "back to rules" CTA (`app_router.dart:149-189`), not a red error.
- **Filter state is not in the URL**: query, category, saved/notes mode and calculator tab are widget
  state (`catalog_screen.dart:60-64`, `bookmarks_screen.dart:28-29`, `penalty_calculator_screen.dart:27`),
  so you can share "the app", never "the rules about overtime".
- **Zero `Navigator.push`** in the whole app; `Navigator.pop` appears only as dialog/sheet dismissal.

## 3. Screen inventory

| # | Route | Screen | LOC | Archetype | Primary action | Loading | Empty | Error | Offline |
|---|---|---|---|---|---|---|---|---|---|
| 1 | `/` | CatalogScreen | 409 | Library / search-first reference | search or open a rule | n/a | ✓ `AppEmptyState` (`:176-191`) | n/a | ✓ |
| 2 | `/rule/:id` | RuleDetailScreen | 416 | Long-form reader + annotations | read / bookmark / note | n/a | n/a (detail) | ✗ (missing-id handled in router) | ✓ |
| 3 | `/calculator` | PenaltyCalculatorScreen | 1220 | Form / calculator (5 tabs) | enter number, copy result | ✗ (sync math) | n/a | ✓ inline `_ErrorText` (`:609-640`) | ✓ |
| 4 | `/sop` | SopScreen | 269 | Emergency procedure list | open a procedure | n/a | ✓ (`:94-110`) | n/a | ✓ |
| 5 | `/sop/:id` | SopDetailScreen | 324 | Step-by-step emergency guide | read steps / copy | n/a | n/a | n/a | ✓ |
| 6 | `/checklist` | ChecklistScreen | 304 | Self-audit modules | start an audit | n/a | ✓ (`:95-111`) | n/a | ✓ |
| 7 | `/checklist/:id` | ChecklistDetailScreen | 239 | Checklist / scoring | tick an item | n/a | ✓ implicit (0%) | n/a | ✓ |
| 8 | `/bookmarks` | BookmarksScreen | 418 | Saved + notes | reopen a saved rule | n/a | ✓ ×2 (`:242-255`, `:282-295`) | n/a | ✓ |
| 9 | `/settings` | SettingsScreen | 659 | Settings | export / import / language | △ (literal `...`, `:373-380`) | n/a | ✗ (snackbar only) | n/a |
| 10 | `/splash` | FleetSplashScreen | 294 | Launch | — | ✓ animated | — | — | — |
| 11 | `/onboarding` | FleetOnboardingScreen | 1002 | Onboarding (4 slides) | finish | — | — | — | — |

**The three "unrouted" files are not dead code.** `RuleDetailScreen`, `SopDetailScreen`,
`ChecklistDetailScreen` are constructed inline by their parent `GoRoute` builders
(`app_router.dart:71, 100, 121`), so the inventory's `page: null` is a parser artifact, not an
orphan. The app has **no unreachable screen**.

The genuinely dead code is elsewhere, and it is all state-layer:

| Symbol | Location | References |
|---|---|---|
| `filteredSopGuidesProvider` | `app_providers.dart:117-134` | **1** (its own definition) — SOP search was designed and never wired |
| `FleetLoadingView` | `core/ui/fleet_loading_view.dart:9` | **0** outside its own file |
| `FleetShimmerCard` | `core/ui/fleet_loading_view.dart:140` | **0** outside its own file |
| `FleetStateSwitcher` | `core/ui/fleet_loading_view.dart:207` | **0** outside its own file |
| `AppColors` (legacy) | `core/constants/app_colors.dart:3-28` | **0 imports** — a second class with the same name as the live token class |

## 4. Screen anatomy

Values below are the ones in code, not the intended ones. Spacing is tokenised almost everywhere:
`AppSpacing` (`app_theme.dart:6-15`: 4/8/12/16/20/24/32), `AppRadius` (`:17-23`: 8/12/16/20).

### 4.1 Catalog (`catalog_screen.dart`) — the whole product in one screen

| Section | Components | Type | Colour | Verdict |
|---|---|---|---|---|
| App bar | 32dp brand tile + "RuleBook" + description on a second line | `titleLarge` 17.5 + `labelSmall` **10.5** (`:86-97`) | `c.brand`, `c.textMuted` | Title is the app name, not the screen; the 10.5sp sub-line is the first unreadable element |
| Search field | `Semantics(textField)` → `TextField`, prefix icon 19, hint `searchRulesHint` | body 14.5 (`:239`), `contentPadding` v14 (`:256`) | `c.surface` on `c.background` | Reachable in **0 taps** — the single best decision on this screen |
| Quick chips (`:263-303`) | 8 keywords in a 44dp horizontal `ListView`, chips 34dp | 12.5 raw `TextStyle` (`:394-398`) | selected `brand` + `onBrand` | **Keywords are hardcoded Indonesian** (`:269-278`: `Tilang`, `Lembur`, `Pesangon`, `UU PDP`…) in an 8-locale app — visible clipped at the right edge in every phone render |
| Read badge (`read_badge.dart:39-102`) | `Icons.menu_book_outlined` + "Legal Literacy Badge 7/31 · Rule Observer" + 5dp bar + share | 13 raw `TextStyle` (`:67-73`) | brand / brand 15% track | Gamification sits **above** the results. Its share button (`:87-98`) is a second, unexplained action above the fold |
| Category rail (`:305-338`) | 7 chips, 44dp track / 34dp visual | 12.5 raw | six category accents | Clipped at "Co…" on both iPhone 6.9" renders and at "Gara…" on Android — with no fade, no scroll cue |
| Result count (`:149-173`) | "31 rules" + conditional Reset filters (44dp) | `labelMedium` 11.5 | `c.textMuted` | Correctly reflects the filtered set |
| Rule card (`rule_card.dart:36-120`) | 38dp category tile, uppercase category, title, 2-line summary, penalty row, bookmark | 10.5 / 14 / 12 / 12 | accent, `textPrimary`, `textSecondary`, `textMuted` | Six semantic elements per row for a job that is "which rule do I need" |

Chrome before the first card, summed from code: 56 (bar) + ~68 (search block) + 44 (chips) + 66
(badge) + 44 (rail) + ~32 (count) + gaps ≈ **350dp** — roughly 40% of a 6.9" viewport. Visible
consequence in `iphone69-1.png`: the first rule card top edge lands at ~30% of the screen.

### 4.2 Rule detail (`rule_detail_screen.dart`) — the product's core surface

| Section | Components | Values | Verdict |
|---|---|---|---|
| App bar | share, copy, bookmark `TapTarget` | icons 20–21 (`:128-149`) | No page title; three unlabelled-looking glyphs (tooltips exist, labels do not) |
| Header | category `Pill`, title, legal basis row with book icon | `headlineSmall` 21, basis `bodySmall` 12 (`:165-185`) | Clean. Legal basis is rendered as **plain text**, not a citation link |
| Consequence card | danger-tinted `AppCard` + scale icon + uppercase label + penalty | label 10.5, value `bodyLarge` 15/600 (`:189-221`) | The strongest element in the app: one glance answers "what happens to me" |
| **Duplicate share** | `TextButton.icon` right-aligned immediately under the card | 13 (`:223-234`) | Same action as the app-bar share, 60dp apart |
| "What it means" | `SectionHeader` + paragraph | `bodyMedium` **13.5**, height 1.65 (`:241-247`) | Reference prose at 13.5sp — smaller than the app's own list titles |
| Do / Don't | `_GuidanceRow` × N with 20dp tick tiles | `bodyMedium` 13.5/1.55 (`:376-416`) | Correct green/red semantics, no colour-only signalling |
| Personal note | `TextField` 3–4 lines, counter, Clear + Save | Save `FilledButton` height **42**, Clear `TextButton` height **40** (`:314`, `:322`) | Both primary-ish controls are below the app's own 44pt floor |
| Related rules | up to 3 `AppCard`s | 14 (`:340-369`) | Chosen by **category**, not by citation (`:118-122`); `pushReplacement` (`:348`) means back goes to the catalog, not the previous rule |

### 4.3 Calculator (`penalty_calculator_screen.dart`)

- Five tabs in a horizontal pill rail, 44dp track / 34dp chips (`:361-443`). At 390dp only ~2.5 tabs
  are visible; the 3rd is cut mid-word ("Pr…") in `iphone69-2.png` — no fade, no scroll indicator.
- Shared result card (`:514-607`): 24sp amount, one context line, dotted breakdown, copy icon — good
  hierarchy, and the only chart-like object in the app.
- **Mixed number formats**: inputs show raw digits (`Rp 5000000`, `:33`), results are formatted
  (`Rp 158.960`). **Localization break**: violation names (`:56-68`) and all three copy payloads
  (`:320-324`, `:334-342`, `:350-355`) are hardcoded Indonesian, so an English user copies
  "Simulasi Lembur RuleBook…".
- **Undersized controls**: `FilterChip` fixed at `height: 32` (`:1084-1091`); checkbox in a 24×24 box
  (`:1013-1022`).
- The one thing to copy elsewhere: `ConstrainedBox(maxWidth: 640)` (`:246-248`) — the **only** screen
  that limits its measure on a tablet.

### 4.4 SOP (`sop_screen.dart` / `sop_detail_screen.dart`)

- List: info banner, category rail (44/34), cards with icon, title, 2-line scenario, category and
  step-count pills (`:206-267`). **No search field in this file at all** — 5 emergency procedures are
  browsable only.
- Detail: scenario card, Rights, numbered `_StepCard`s with warning/tip callouts, hotline list
  (`:118-213`). Callouts keep body text in `textSecondary` and tint only the icon, with a comment
  explaining why (`:294-323`) — a thoughtful, documented contrast decision.
- **Hotline numbers are plain `Text`** (`:201-207`) — in an emergency the number cannot be tapped,
  copied or dialled, though `url_launcher` is already wired elsewhere (`commercial_contact_cards.dart:70`).

### 4.5 Checklist (`checklist_screen.dart` / `checklist_detail_screen.dart`)

- List card: icon, title, audience (1 line, ellipsised), percentage `titleMedium` right-aligned,
  6dp progress bar, "5/8 items fulfilled" + "Start Audit ›" (`:220-302`). Percentage and title are the
  same visual weight in the same row — the score should own that corner.
- Detail: 4-band status (`≥100 / ≥70 / ≥40 / else`, `:31-36`) → success/warning/danger, tinted summary
  card, 8dp progress, items as tappable cards with a 22×22 checkbox (`:148-159`) and a "Crucial" pill.
- Status label and percentage are painted in `tone` on a `tone`-tinted card (`:86`, `:100`, `:115`).
  Measured: success `#059669` on `#ECFDF5` = **3.58:1**; danger `#DC2626` on `#FEF2F2` = **4.41:1** —
  both under 4.5 for 14sp/600 text.

### 4.6 Bookmarks (`bookmarks_screen.dart`)

- Two modes in a custom segmented control (`:109-171`), counts inside labels ("Saved Rules & Notes · 5").
- **Hidden state bug**: `passesFilter()` applies to *both* lists (`:40-50`), but the chips that set it
  render only in notes mode (`:70-95`) — filter in Notes, switch to Saved, and the saved list is
  silently filtered with no visible control to explain or undo it.
- Note cards add a delete `TextButton` at 44dp (`:365-382`) behind a confirmation dialog.

### 4.7 Settings (`settings_screen.dart`)

- Privacy card → Appearance (`SegmentedButton<ThemeMode>`, icon-only segments + tooltips) → Language
  (sheet) → Timezone (sheet) → Data (export / import / clear) → Disclaimer → About.
- **Accessible-name inconsistency**: the timezone row is `Semantics(button: true, label: …)`
  (`:216-241`); the language, export, import and clear rows are bare `AppCard`/`PressScale`
  (`:192`, `:249`, `:288`, `:319`). One row announces itself as a button; four do not.
- About lists app/version/subdomain/applicationId/license (`:367-389`) — **nothing about the content**:
  no regulation cut-off, no "last reviewed", no source edition. The language list has 8 entries
  (`:25-34`), matching `app_localizations_*.dart`.

### 4.8 Splash & onboarding

- Splash: 500ms scale 0.94→1.0 + slide + staggered text, reduced motion honoured (`fleet_splash_screen.dart:32-96`),
  then a 750ms handoff (`:98-114`). Well executed, but it paints its own grey ramp
  `#0F1115 / #F9FAFB / #111827 / #4B5563` (`:136-145`) instead of `AppColors`, so the first frame does
  not match `#F8FAFC`/`#0A0E1A`.
- Onboarding: 4 slides (`:119-141`), `LayoutBuilder` illustration scaling (`:258`, `:627`), page haptics
  (`:190`), skip path present.

### 4.9 Domain checks (the five that decide whether this product is trustworthy)

| Check | Evidence | Verdict |
|---|---|---|
| **Search — exists?** | `catalog_screen.dart:118-129` persistent field; 8 quick chips | ✓ present, 0 taps |
| **Search — what does it search?** | `app_providers.dart:108-111`: `rule.title`, `rule.summary`, `rule.legalBasis`, `rule.keywords` — the **Indonesian source fields**, never `localizedTitle/Summary/Explanation`, never penalty, never Dos/Donts | ✗ **CRITICAL.** In the English UI the card reads "Working Hours & Overtime Wage Calculation"; the string `overtime` occurs **0 times** in `rules_database.dart` (also `highway` = 0, `severance` = 0). Typing the word on the card returns 0 results. `AGENTS.md:62` mandates filtering "judul, kata kunci, nomor pasal, dan deskripsi" — description is not searched either |
| **Search — result context/highlight** | `rule_card.dart:67-101` shows title + summary + penalty only; there is no match-highlight code anywhere | ✗ the user cannot see *why* a card matched |
| **Long-form reading** | body `bodyMedium` 13.5/1.65 (`app_theme.dart:383-388`, `rule_detail_screen.dart:243-246`); measure = screen − 32dp (`app_scroll.dart:38-48`) ≈ 358dp ≈ 50 chars on a 390dp phone; **no max width** on detail (`:153`) so an iPad (1032dp) gives ~150 chars/line | ✗ 13.5sp reference prose + unbounded tablet measure |
| **Cross-reference** | `legalBasis` is inert text (`rule_detail_screen.dart:176-182`); "Related" = same category, max 3 (`:118-122`); the calculator repeats "Pasal 281" as a string literal (`penalty_calculator_screen.dart:56`) | ✗ nothing links a rule to the article it cites; the user retypes "Pasal 281" into search |
| **Version / effective date** | `RuleItem` has 10 fields, none temporal (`rule_item.dart:3-13`); no "berlaku/effective/updated/as of" string exists outside content prose; the only date-shaped UI is the app version (`settings_screen.dart:373-380`) and the disclaimer ("does not constitute formal legal counsel", `app_localizations_en.dart:234-235`) | ✗ **CRITICAL.** A law reference with no cut-off date cannot be trusted, and `UU 22/2009`, `PP 35/2021` and `UU PDP` have all been amended in ways that change the numbers shown |
| **Offline** | all content `static const` (`rules_database.dart:7`); no `http`/`dio` in `pubspec.yaml`; `url_launcher` used only for mailto in settings (`commercial_contact_cards.dart:70`); zero network on any read path | ✓ **passes cleanly.** The app's headline promise is real |

## 5. Visual evidence review (real renders)

Sources: `docs/store/metadata/ios-screenshots/en-US/iphone69-{1..4}.png` (1290×2796),
`ipad13-{1..4}.png` (2064×2752), `docs/store/metadata/android/en-US/images/phoneScreenshots/{1..4}.png`
(1080×1920). Produced by `test/store_screens/store_screens_test.dart` — real app, seeded demo data.

| # | Severity | Finding | Evidence | Fix |
|---|---|---|---|---|
| 1 | **CRITICAL** | No "as of"/effective-date anywhere in the UI — the rule cards, detail header and About card all read as timeless. Nothing tells the reader whether this is 2021 law or 2026 law. | `iphone69-1.png` (cards carry category, title, summary, fine — no date); `settings_screen.dart:367-389` | Add `effectiveAsOf` + `lastReviewed` to `RuleItem`; render "Per 1 Jan 2026 · UU 22/2009" under the legal basis; show a global content-version stamp in catalog footer and About |
| 2 | **CRITICAL** | Category labels at 10.5sp in light theme fall under 4.5:1 — washed-out "TRAFFIC & ROAD TRANSPORT" on every card. Measured: traffic 4.10, labor 3.77, consumer 3.19 on white. | `iphone69-1.png`, `iphone69-3.png`; `rule_card.dart:58-64`; `checklist_detail_screen.dart:98-121` | Text-safe accent variants (`#0369A1`, `#047857`, `#B45309`) for text; bright ones only for fills/icons |
| 3 | **HIGH** | Horizontal chip rails clip mid-word with no fade or cue, on the two most-used screens. Users never learn that `Consumer`, `Safety`, `Ethics` and 3 of the 5 calculator tabs exist. | `iphone69-1.png` ("Co"), `iphone69-2.png` ("Pr"), `iphone69-3.png` ("Co"), `android/1.png` ("Gara"), iPad (`ipad13-1.png`) shows all 7 — proving it is a width problem | Wrap rails in a trailing `ShaderMask` fade (24dp) + 8dp end padding, or replace the 7-chip rail with a single "Filter · 2" button opening a sheet |
| 4 | **HIGH** | Reading surface: detail body is smaller than the list previews around it, and on tablet the text column spans ~1000dp with ~150 characters per line. | `rule_detail_screen.dart:241-247`, `:153`; `ipad13-1.png` (single full-bleed column, same as phone) | `bodyLarge` 16/1.6 for `fullExplanation`; `ConstrainedBox(maxWidth: 680)` on detail, same pattern the calculator already uses (`penalty_calculator_screen.dart:246-248`) |
| 5 | **HIGH** | 44dp is the app's touch floor and it is applied everywhere — below Android's 48dp minimum, and the note Save/Clear buttons go lower (42 / 40). | `catalog_screen.dart:284,316,361`; `rule_detail_screen.dart:314,322`; `checklist_detail_screen.dart:148-151`; `penalty_calculator_screen.dart:1084` | Raise the `TapTarget` default to 48 (`tap_target.dart:20`), chips to 48, note buttons to theme default |
| 6 | **MEDIUM** | Chrome consumes ~40% of the first screen before a single rule appears; the badge (a gamification device) outranks the content it sits above. | `iphone69-1.png`; `catalog_screen.dart:136-147` | Move the badge below the first screen of results, or collapse it to a one-line pill inside the results header |
| 7 | **MEDIUM** | The same tiny grey is used for "unsaved bookmark" (an interactive 20dp icon, 2.45:1) and for metadata. Non-text UI needs 3:1. | `rule_card.dart:114`; `iphone69-1.png` (second card's bookmark is nearly invisible) | `c.borderStrong` or `c.textMuted` for the empty bookmark; `c.textFaint` for purely decorative lines only |

What the renders get **right** and must not be thrown away: the consequence card on detail
(`rule_detail_screen.dart:189-221`), the flat hairline card on tinted page (no shadows anywhere), the
numbered SOP step card, the two-mode saved screen, the glass bottom bar that never covers the last row
(the `AppScroll.bottomClearance` maths at `app_scroll.dart:14-23`), and the dark palette, which passes
contrast where the light one does not.

## 6. Scorecard

`score = Σ(category × weight) / Σ(weight)`; touch and a11y weigh 1.5×.

| # | Category | W | P/W/F | Score | Grade |
|---|---|---|---|---|---|
| 1 | Visual hierarchy & composition | 1.0 | 4/3/2 | 61.1 | D |
| 2 | Typography | 1.0 | 4/4/4 | 50.0 | F |
| 3 | Color & theming | 1.0 | 7/3/2 | **50.0** (auto-capped from 70.8) | F |
| 4 | Spacing & layout | 1.0 | 7/6/1 | 71.4 | C |
| 5 | Navigation | 1.0 | 9/1/1 | 86.4 | B |
| 6 | Touch & gesture | **1.5** | 6/2/2 | **50.0** (auto-capped from 70.0) | F |
| 7 | Platform conventions | 1.0 | 6/2/2 | 70.0 | C |
| 8 | Motion & animation | 1.0 | 5/3/2 | 65.0 | D |
| 9 | Content states | 1.0 | 6/1/3 | 65.0 | D |
| 10 | Accessibility | **1.5** | 3/2/6 | 36.4 | F |
| 11 | Responsive & adaptive | 1.0 | 4/2/4 | 50.0 | F |
| 12 | Performance as design | 1.0 | 5/3/0 | 81.3 | B |
| 13 | AI-slop detection | 1.0 | 5/3/0 | 81.3 | B |
| | **Weighted total** | 14.0 | | **61.5** | **D** |

Arithmetic: `(61.1 + 50.0 + 50.0 + 71.4 + 86.4 + 75.0 + 70.0 + 65.0 + 65.0 + 54.5 + 50.0 + 81.3 + 81.3) / 14 = 861.0 / 14 = 61.5`.

**Auto-fails applied.** Color: text under 4.5:1 in light theme (category accents, checklist status).
Touch: a primary CTA below 48dp (note Save 42, Clear 40).

### Item-level failures (the ones that set the grade)

| SEVERITY | CATEGORY | Location | Issue | Fix |
|---|---|---|---|---|
| CRITICAL | Content trust | `rule_item.dart:3-13` | No `effectiveAsOf` / `lastReviewed` field; no screen shows a content date | Add both fields, render on detail + About + catalog footer |
| CRITICAL | Search | `app_providers.dart:97-115` vs `rule_l10n_extension.dart:5-41` | Search runs over Indonesian source fields while every screen renders localized ones; "overtime" = 0 hits in `rules_database.dart` | Build the haystack from `localizedTitle/Summary/Explanation/Dos/Donts/Penalty` for the active locale |
| CRITICAL | A11y / Color | `app_colors.dart:129-157` + `rule_card.dart:58-64` | Light-theme category text 3.19–4.10:1; `foundations.md:111` requires 4.5 in *both* themes; the guard only runs dark (`dark_contrast_test.dart:22`) | Text-safe accent set; parameterise the contrast test by theme |
| HIGH | A11y | `rule_card.dart:36-120`, `checklist_detail_screen.dart:136-159` | Tappable cards expose no button role and no merged label; `MergeSemantics` = 0 uses | `Semantics(button: true, label: '<title>. <penalty>.', child: MergeSemantics(...))` |
| HIGH | Touch | `rule_detail_screen.dart:314,322`; `penalty_calculator_screen.dart:1084`; `tap_target.dart:20` | 40/42/32dp controls; global 44dp default | 48dp default; remove local `minimumSize` overrides |
| HIGH | Typography | `app_theme.dart:383-388`, `:409-415` | Reader body 13.5sp; `labelSmall` 10.5 used for category + legal meta; 62 `fontSize:` declarations, 31 raw `TextStyle(` in features | Reader body 16/1.6; meta floor 12; move the 31 raw styles into `TextTheme` |
| HIGH | Responsive | whole app except calculator | iPad render = phone layout at 1000dp; no `NavigationRail`; 0 `DisplayFeature`; 1 `maxWidth` in the entire app | Breakpoint at 840dp: rail + 720dp content column |
| HIGH | Platform | `app_scroll.dart:10-12` | `BouncingScrollPhysics` forced app-wide, including Android | `Platform.isIOS ? Bouncing : Clamping` |
| MEDIUM | Content states | `fleet_loading_view.dart:9,140,207` | Loading/shimmer/state-switcher exist and are used 0 times; export/import have no progress or retry | Wire `FleetStateSwitcher` around backup export/import |
| MEDIUM | Navigation | `bookmarks_screen.dart:40-50` vs `:70-95` | Filter applies to saved list but its control is hidden in notes mode | Render the chip row in both modes, or scope the filter to notes only |
| MEDIUM | Domain | `sop_detail_screen.dart:201-207` | Hotline numbers are not tappable | `launchUrl(Uri(scheme: 'tel', path: number))` |
| MEDIUM | System | `app_theme.dart:25-30` vs `app_motion.dart:3-20`; `constants/app_colors.dart:3-28` | Two `AppMotion` classes (150/220 vs 150/250/350), two `AppColors` classes, 17 dead hex values | One motion file, one colour file; delete the rest |
| POLISH | Motion / Typography | `stagger_fade_in.dart:25-26`; 0 × `FontFeature.tabularFigures` | Stagger only in the catalog; Rupiah amounts shift width as digits change | Wrap the other lists; add tabular figures |

## 7. Harsh verdict

1. **This is a beautifully built reference book with no publication date.** Best shell in the fleet —
   semantic tokens, dark-mode contrast test, real empty states, working offline — and then the content
   says "UU No. 22 Tahun 2009" with no indication whether that is the current text. A lawyer would not
   use it; a rider at a roadside stop will, and that is the problem.
2. **Search is the product, and search does not search the product.** Eight languages of translated
   content sit in the database while the query matches Indonesian originals, so an English user gets an
   empty screen for a word printed on the card in front of them. All eight quick chips are Indonesian
   words in every locale.
3. **The design system is real, and it is half-enforced.** 121 hex literals is nothing next to the
   fleet's 593 — until you notice the light theme breaks the app's own 4.5:1 clause, the contrast test
   only runs in dark, two `AppColors` and two `AppMotion` classes are importable, and the loading
   states that were built are never used. The discipline is there; the enforcement is not.

## 8. Competitor analysis

Scope: products that solve the same job — *find the exact rule that applies to me, offline, fast*.
Feature level, IA level; verify specifics before copying.

| Product | Model | Core IA | What they do that RuleBook does not |
|---|---|---|---|
| **eCFR** (US federal register) | free, official | Section view with a live "current as of" banner, permanent citation URL per section, inline links to every cited section | As-of dating + real cross-reference graph — the two things this app lacks |
| **LawStack CFR / USC** | freemium, offline-first | Downloaded titles, full-text search with hit highlighting, bookmarks + notes, "effective date" in the header | Offline like RuleBook, but dates every page and highlights the match |
| **peraturan.go.id / JDIH BPK** | free, official (ID) | Regulation page with status (berlaku / diubah / dicabut), effective date, and "mengubah/mengubah dengan" chains | Status + amendment chain — the Indonesian-specific trust layer |
| **Wikipedia (iOS)** | free | Reader-first: article TOC, text-size/theme sheet, inline citations, 6-action persistent toolbar | Reader controls and citation affordances |
| **Craft** | freemium | Document reader with near-zero chrome, 17sp body, 24dp margins, floating tool clusters | Reading typography discipline |
| **Evernote** | freemium | Search with match highlighting, result count, recency, tag chips, filters | Search-result legibility |
| **Finimize** | freemium | Article header with date + reading time, TOC, 17sp body at ~40 chars | Date + reading time + TOC on long text |

**Positioning gap.** RuleBook's differentiators are genuine and rare together: **100% offline, no
account, no ads, 8 languages, plain-language "what happens to me" framing with the formal article
number attached**. Nothing on the list does all five. But every serious legal-reference product on the
list dates its content, and this one does not — which turns a strength (offline permanence) into a
liability (permanently stale).

**Three competitor moves worth copying, cheapest first**

1. **"Current as of" line** (eCFR) — one field, one line under the legal basis, plus a global stamp.
   Two hours of work; it is the difference between a reference and a rumour.
2. **Search hits shown as context** (Evernote) — highlight the matched phrase inside the summary or the
   article number in the result row. Turns a filter into a search.
3. **Text-size sheet** (Wikipedia) — 4 steps, persisted, clamped at 1.6× (already the app's cap,
   `text_scale.dart:42`). Gives the reader control without breaking the layout.

## 9. Mobbin reference delta

Pulled with `mobbin screens "<query>" --platform ios --deep --previews`, downloaded and read as images.
Every value below was read off the reference render.

### 9.1 Reader → Wikipedia · `mobbin.com/screens/20bba34c-ecb2-4250-9162-e820774e55e3`

| Dimension | RuleBook | Wikipedia | Verdict |
|---|---|---|---|
| Body size / line height | 13.5sp / 1.65 (`app_theme.dart:383-388`) | ~17sp / ~1.55 | **worse** — RuleBook's reference prose is smaller than its own list titles |
| Measure on phone | ≈358dp ≈ 50 chars | ≈40 chars, 20dp margins | worse — slightly too wide for 13.5sp text |
| Title treatment | 21sp `headlineSmall` (`rule_detail_screen.dart:167`) | ~28sp serif + 15sp grey subtitle | worse — no editorial signal that this is a document, not a list item |
| Reader controls | none | persistent 6-action bar (tools, language, save, share, text size, find) | **missing** — no text-size, no find-in-page |
| Citation affordance | article number as inert text (`:176-182`) | inline `[1]` links, tappable | worse |
| Persistence feedback | none on read | "Article added to 'New Zealand'" toast | missing |

### 9.2 Long article → Craft · `mobbin.com/screens/024af253-8ac7-4825-9b50-7576d8fc8b28`

| Dimension | RuleBook | Craft | Verdict |
|---|---|---|---|
| Chrome | app bar + duplicate share button in body (`:128-137` vs `:223-234`) | floating back/share/more pills, zero persistent bar | worse — two share entry points, 60dp apart |
| Body | 13.5/1.65 | ~17/1.6 | worse |
| Margins | 16dp (`app_scroll.dart:38-48`) | 24dp | worse |
| Section labels | uppercase 11.5 muted (`app_ui.dart:75-83`) | 17sp sentence-case headings | different — RuleBook's labels scan better, the sections read worse |
| Note-taking | inline 3-line field + counter (`rule_detail_screen.dart:265-338`) | attachments/pens toolbar | equal for the job (RuleBook's note is better placed) |

### 9.3 Search results → Evernote · `mobbin.com/screens/ea563c60-6b66-4d41-895b-63f25244b50a`

| Dimension | RuleBook | Evernote | Verdict |
|---|---|---|---|
| Match context | none — card shows title/summary/penalty only (`rule_card.dart:67-101`) | matched term highlighted in 3 places inside the snippet | **worse** — user cannot see why a row matched |
| Result count | "31 rules" (`catalog_screen.dart:153-158`) | "3 RESULTS" header above the list | equal |
| Scope / type filter | 7 category chips, one dimension | filter chips (attachments, images, checkboxes, tag) | worse — no type scope (rules vs SOP vs checklist) |
| Recency signal | none | "16 min ago" per row | missing (and impossible without a date model) |
| Locale | query matches Indonesian fields only | query matches the visible text | **worse — this is the fatal one** |

### 9.4 Article → Finimize · `mobbin.com/screens/6aef933a-e3de-4ae3-bd63-c06cdb6e99af`

| Dimension | RuleBook | Finimize | Verdict |
|---|---|---|---|
| Date on document | **absent** | "1 May 2026 · 21 min read" under the byline | **worse — CRITICAL for a legal reference** |
| Table of contents | none | collapsible TOC with 5 numbered entries | missing — a 6-section rule page has no outline |
| Body | 13.5 | ~18 | worse |
| Inline links | none | cited term underlined and linkable | missing |

Particle News (`mobbin.com/screens/d3e10104-88c5-4dbf-8c07-cc9fcd171cc5`) supplies the scan-rate
number: 4 elements per row at ~5 rows/screen, against RuleBook's 6 elements at ~2.3 rows/screen.

**Cross-cutting deltas (component level)**

| Component | RuleBook | Reference norm | Action |
|---|---|---|---|
| Reader body | 13.5sp | 17–18sp | `bodyLarge` 16–17 for prose |
| Reader measure | unbounded | 640–720dp max | `ConstrainedBox` on all detail screens |
| Chip rail | 44dp, clips | segmented control or fading scroller | fade + 48dp |
| Search result | no context | match highlight + context | rebuild `RuleCard` in search mode |
| Result count | present | present | keep |
| Date stamp | absent | always present | add to model + detail + About |
| Reader controls / actions | none; 3 app-bar actions | text-size sheet; 1 primary + overflow | add sheet, collapse share/copy |

## 10. Missing features, screens and components

Ranked by user value per hour.

### Screens missing

| Screen | Why it matters | Reference |
|---|---|---|
| **Search results (cross-entity)** | 31 rules are searchable; 5 SOPs and 4 checklists are not (`sop_screen.dart` has no `TextField`; `filteredSopGuidesProvider` is dead). A user looking for "kebakaran" finds a rule but not the fire SOP | Evernote |
| **Article/statute page** (`/statute/:id`) | `legalBasis` is a string; the cited UU has no destination. One screen listing the article, its amendments, and the rules that cite it would carry the whole product | eCFR, peraturan.go.id |
| **Reader settings sheet** | Text size, serif toggle, theme override — the app caps at 1.6× but gives no control below it | Wikipedia |
| **Content changelog** (`/changelog`) | "What changed in this update" — the missing half of offline trust | peraturan.go.id |
| **Glossary** | "UPMK", "PHK", "PDP", "K3" appear untranslated inside translated sentences; an A–Z would remove the biggest comprehension tax in the calculator | — |

### Features missing

- **Effective / reviewed date** per rule and a global content version (see §4.9). Non-negotiable.
- **Locale-aware search**, match highlighting, and search over SOPs/checklists (provider is dead today).
- **Citation cross-links** — tap a legal basis to see the rules that cite it.
- **Tappable hotlines** and per-step copy in SOP detail (`sop_detail_screen.dart:17-41`).
- **Export a checklist result** (PDF/text) — the audit produces a score and then drops it.
- **Undo** on note delete and checklist reset; **reading progress** per rule.

### Components missing

`SearchResultRow` (match highlight) · `ReaderBody` (16sp + max width) · `DateStamp` · `CitationLink` ·
`TextSizeSheet` · `SectionToc` · a wired `FleetStateSwitcher` · one `CategoryChip` instead of the four
near-copies in `catalog_screen.dart:341`, `sop_screen.dart:126`, `checklist_screen.dart:133`,
`bookmarks_screen.dart:174`.

## 11. Improvement plan

Effort in engineer-hours for one developer who knows this codebase. Deltas are weighted points on 61.5.

### P0 — broken (blocks a C, 12 h)

| # | Change | Files | Effort | Score delta |
|---|---|---|---|---|
| P0-1 | Add `effectiveAsOf` + `lastReviewed` to `RuleItem`; render under legal basis, in the catalog footer, and in About | `rule_item.dart:3-13`, `rules_database.dart` (31 entries), `rule_detail_screen.dart:170-185`, `settings_screen.dart:367-389` | 3 h | Content 65 → 80 · **+1.5** |
| P0-2 | Locale-aware search: build the haystack from `localizedTitle/Summary/Explanation/Dos/Donts/Penalty`; add `fullExplanation` per `AGENTS.md:62` | `app_providers.dart:97-115` + `rule_l10n_extension.dart` | 3 h | Hierarchy +5, Content +5 · **+1.1** |
| P0-3 | Light-theme text-safe accents (`#0369A1`, `#047857`, `#B45309`, `#BE185D`) used for 10.5–14sp label text; parameterise `dark_contrast_test` over both themes | `app_colors.dart:129-157`, `rule_card.dart:58-64`, `checklist_detail_screen.dart:86-121`, `test/trace/dark_contrast_test.dart:22` | 3 h | Color 50 → 75, A11y 36 → 50 · **+4.0** |
| P0-4 | Reader typography: prose at 16/1.6, meta floor 12sp, max width 680 on detail | `app_theme.dart:377-415`, `rule_detail_screen.dart:241-247,153` | 2 h | Typography 50 → 68 · **+1.5** |
| P0-5 | 48dp touch floor: `TapTarget` default 48, chips 48/38, remove 40/42 overrides, FilterChip 48 | `tap_target.dart:20`, `rule_detail_screen.dart:314,322`, `penalty_calculator_screen.dart:1084` | 1 h | Touch 50 → 70 · **+3.0** |

**After P0: ≈ 73 (C).**

### P1 — system (19 h)

| # | Change | Files | Effort | Delta |
|---|---|---|---|---|
| P1-1 | Search result row with match highlight + result context; scope chips (Rules / SOP / Checklists) | new `widgets/search_result_row.dart`, `app_providers.dart`, `catalog_screen.dart:192-207` | 5 h | Hierarchy +6, Content +4 · **+1.1** |
| P1-2 | SOP + checklist search entries reusing the provider | `sop_screen.dart:44-67`, `checklist_screen.dart:45-68` | 2 h | Nav +2, Content +3 · **+0.5** |
| P1-3 | Citation cross-links: `legalBasis` → filter by article; "cited by" list on detail | `rule_detail_screen.dart:176-185,340-369` | 4 h | Hierarchy +4, Content +4 · **+0.8** |
| P1-4 | Tablet layout: 840dp breakpoint → `NavigationRail` + 720dp content column | `navigation_shell.dart`, all list screens | 4 h | Responsive 50 → 72, Layout +4 · **+2.5** |
| P1-5 | Semantics pass: button role + merged label on every tappable card; label the 4 settings rows | `rule_card.dart`, `sop_screen.dart:206`, `checklist_screen.dart:220`, `settings_screen.dart:192,249,288,319` | 3 h | A11y 50 → 66 · **+2.2** |
| P1-6 | Tappable hotlines + copy-step in SOP | `sop_detail_screen.dart:159-213`, `:17-41` | 1 h | A11y +4, Platform +2 · **+0.8** |

**After P0+P1: ≈ 81 (B).**

### P2 — polish (9 h)

| # | Change | Effort | Delta |
|---|---|---|---|
| P2-1 | Text-size sheet (4 steps, persisted, clamped 1.6×) + serif toggle | 3 h | Type +5, Responsive +3 · **+0.8** |
| P2-2 | Delete `lib/core/constants/app_colors.dart`; merge the two `AppMotion`s; wire or delete the three `Fleet*` state widgets | 2 h | Color +2, Motion +5 · **+0.5** |
| P2-3 | Fix bookmarks hidden-filter state; add reproducible filter chip row to Saved mode | 0.5 h | Content +3 · **+0.3** |
| P2-4 | Splash palette → `AppColors` (remove the four off-brand greys) | 0.5 h | Color +2 · **+0.1** |
| P2-5 | Trailing `ShaderMask` fade on every horizontal rail; haptics on bookmark toggle | 1 h | Layout +4 · **+0.3** |
| P2-6 | Tabular figures on all currency amounts; unify input vs result number formatting | 1 h | Type +3 · **+0.2** |
| P2-7 | `StaggerFadeIn` on SOP / checklist / bookmark lists | 1 h | Motion +4 · **+0.3** |

**After P0+P1+P2: ≈ 84 (B).** A true **A** additionally requires the missing screens in §10
(statute page, changelog, glossary), `MergeSemantics` coverage of every interactive row, and a
light-theme contrast test in CI — roughly 3 more days.

## 12. Definition of done

- [ ] `grep -c "effectiveAsOf\|lastReviewed"` ≥ 1 in the model and ≥ 3 render sites; every rule shows
      a date the reader can see
- [ ] Searching a word printed in the *visible* title returns that rule in all 8 locales (add a test
      iterating `supportedLocales` × a term extracted from `localizedTitle`)
- [ ] `grep -rc "Color(0x" lib/features` → 0 outside the share-card canvas, and the canvas themes move
      into `app_colors.dart`
- [ ] Contrast test runs **both** themes; 0 text nodes under 4.5:1 and 0 UI components under 3:1
- [ ] Every tappable card announces `button: true` and one merged label; `MergeSemantics` count ≥
      interactive-row count; `Semantics(` density ≥ 1 per screen
- [ ] `grep -rn "height: 44\|Size(0, 4[0-7])" lib/features` → 0; detail prose ≥ 16sp, ≤ 75 chars/line
      on phone, ≤ 90 on tablet
- [ ] No rail clips without a trailing fade at 320dp; `NavigationRail` above 840dp
- [ ] Hotlines dial; SOP steps copy individually
- [ ] `filteredSopGuidesProvider` used or deleted; `constants/app_colors.dart` deleted; one `AppMotion`
- [ ] Scorecard re-run ≥ 83 with evidence

## Appendix — method and reproduction

- **Sitemap / inventory**: parsed from `lib/core/router/app_router.dart` (11 `GoRoute` nodes, 5 shell
  branches, 3 nested detail routes, 1 root settings route) and cross-checked against the fleet
  `_inventory.json` entry (11 routes / 71 Dart files / 8 locales).
- **Counts** (`grep -o` over `lib/`): `Color(0x` 121 (theme 62 · constants 17 · core/ui 16 · features 26);
  `TextStyle(` 67 (features 31 · theme 25 · core/ui 10 · core/widgets 1); `fontSize:` 62;
  `Semantics(` 10 + `semanticLabel` 9 = **19** tokens (features 5 · core/ui 5 · elsewhere 9);
  `MergeSemantics` 0; `Navigator.push` 0; `RefreshIndicator` 0; `HapticFeedback` 8;
  `SafeArea(` 5; `TextOverflow` 20; `maxLines:` 21; `LayoutBuilder` 3; `SingleChildScrollView` 5.
  `Navigator.pop` was excluded from navigation debt (dialog/sheet dismissal).
- **Spacing discipline**: 76 `SizedBox(height: AppSpacing.*)` vs 29 hardcoded gap sizes; 6 raw numeric
  `EdgeInsets` in `lib/features` — the 4/8 grid is genuinely applied (`app_theme.dart:6-15`).
- **Contrast**: computed with the WCAG relative-luminance formula over the literal palette values in
  `app_colors.dart:129-187`, not estimated from screenshots. Category accents measured against
  `#FFFFFF` (card surface) and `#F8FAFC` (page).
- **Renders**: `docs/store/metadata/ios-screenshots/en-US/iphone69-{1..4}.png` (1290×2796),
  `ipad13-1.png` (2064×2752), `docs/store/metadata/android/en-US/images/phoneScreenshots/1.png`
  (1080×1920). Produced by `test/store_screens/store_screens_test.dart` with `STORE_DEMO` seeding
  (`core/demo/store_demo.dart:7-21`) — real app, seeded data.
- **Tests inspected, not executed** (read-only audit): `test/trace/dark_contrast_test.dart` (9 routes,
  dark only), `test/store_screens/store_landscape_test.dart` (5 viewports), `test/rule_localization_test.dart`
  (8 locales × 31 rules), `test/trace/press_scale_tap_test.dart`, `test/validators_test.dart`.
- **Mobbin**: 5 queries (`documentation app reading`, `encyclopedia article`, `search results list`,
  `legal reference`, `wikipedia article reading`); 6 images downloaded and read (Wikipedia ×2, Craft,
  Particle News, Evernote, Finimize). URLs above are `mobbin.com/screens/<uuid>` without tracking tags.
- **Not done, by rule**: no `flutter build/run/test/analyze`, no dev server, no source edit, no version
  bump. This document is the only change.
