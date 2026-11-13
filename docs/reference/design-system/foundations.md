---
type: Reference
title: Design System Foundations
description: Visual tokens and theme for RuleBook.
status: active
last-updated: 2026-11-13
---

# Foundations — RuleBook

SSOT: [`DESIGN.md`](../../../DESIGN.md) · Panduan ini diturunkan dari kode tema yang ada, bukan sebaliknya: bila nilai di sini berbeda dengan kode, kodelah yang benar — perbarui dokumen ini.

## Sumber token di kode

- [`lib/core/constants/app_colors.dart`](../../../lib/core/constants/app_colors.dart)
- [`lib/core/theme/app_colors.dart`](../../../lib/core/theme/app_colors.dart)
- [`lib/core/theme/app_icons.dart`](../../../lib/core/theme/app_icons.dart)
- [`lib/core/theme/app_theme.dart`](../../../lib/core/theme/app_theme.dart)
- [`lib/core/theme/app_motion.dart`](../../../lib/core/theme/app_motion.dart) (durasi & kurva gerak)

## Tema

- **Material 3** (`useMaterial3: true`).
- **Terang + gelap**: `theme` dan `darkTheme` dipasang di `lib/main.dart`.

## Palet warna

Nilai dibaca dari konstanta `Color(0x…)` di berkas sumber. Gunakan lewat nama token, jangan menyalin heksa.

### `app_colors.dart`

| Token | Nilai | Catatan |
|---|---|---|
| `primary` | `#4F46E5` | Indigo 600 |
| `primaryLight` | `#818CF8` | Indigo 400 |
| `primaryDark` | `#3730A3` | Indigo 800 |
| `secondary` | `#0F172A` | Slate 900 |
| `accent` | `#F59E0B` | Amber (Codex/Gavel) |
| `success` | `#10B981` | Emerald |
| `danger` | `#EF4444` | Red for Violations/Penalties |
| `bgDark` | `#0B0F19` |  |
| `bgSurface` | `#111827` |  |
| `bgCard` | `#1F2937` |  |
| `border` | `#374151` |  |
| `trafficTag` | `#0284C7` | Blue |
| `laborTag` | `#10B981` | Green |
| `privacyTag` | `#8B5CF6` | Purple |
| `consumerTag` | `#F59E0B` | Amber |
| `safetyTag` | `#EF4444` | Red |
| `ethicsTag` | `#EC4899` | Pink / Fuchsia |
| `indigo50` | `#EEF2FF` |  |
| `indigo100` | `#E0E7FF` |  |
| `indigo300` | `#A5B4FC` |  |
| `indigo400` | `#818CF8` |  |
| `indigo500` | `#6366F1` |  |
| `indigo600` | `#4F46E5` |  |
| `indigo700` | `#4338CA` |  |
| `indigo800` | `#3730A3` |  |
| `indigo900` | `#312E81` |  |
| `slate50` | `#F8FAFC` |  |
| `slate100` | `#F1F5F9` |  |
| `slate200` | `#E2E8F0` |  |
| `slate300` | `#CBD5E1` |  |
| `slate400` | `#94A3B8` |  |
| `slate500` | `#64748B` |  |
| `slate600` | `#475569` |  |
| `slate700` | `#334155` |  |
| `slate800` | `#1E293B` |  |
| `slate900` | `#0F172A` |  |
| `slate950` | `#080C17` |  |
| `emerald500` | `#10B981` |  |
| `emerald600` | `#059669` |  |
| `emerald400` | `#34D399` |  |
| `amber500` | `#F59E0B` |  |
| `amber600` | `#D97706` |  |
| `amber400` | `#FBBF24` |  |
| `red500` | `#EF4444` |  |
| `red600` | `#DC2626` |  |
| `red400` | `#F87171` |  |
| `sky600` | `#0284C7` |  |
| `sky400` | `#38BDF8` |  |
| `violet600` | `#7C3AED` |  |
| `violet400` | `#A78BFA` |  |
| `pink600` | `#DB2777` |  |
| `pink400` | `#F472B6` |  |

### Literal heksa tambahan di berkas tema

Nilai berikut dipakai langsung (tanpa nama token) di berkas sumber di atas:

`#000000`, `#000000 (alpha 20%)`, `#000000 (alpha 60%)`, `#0A0E1A`, `#0C2A22`, `#0E1320`, `#121726`, `#171D30`, `#1C2143`, `#1E263A`, `#27304A`, `#2A2110`, `#2C1518`, `#364159`, `#8090A6`, `#C3CCDA`, `#ECFDF5`, `#EDF1F6`, `#FEF2F2`, `#FFFBEB`, `#FFFFFF`

Utang token: bila sebuah nilai dipakai berulang, angkat jadi konstanta bernama (DS-3).

## Tipografi

- Tidak ada keluarga font kustom ter-bundle di `pubspec.yaml`; teks memakai font bawaan platform.

## Radius

Nilai `BorderRadius.circular(...)` yang dipakai di tema/`main.dart`: `6`.

## Motion

Dari `AppMotion`: `fast` 150 ms, `base` 250 ms, `slow` 350 ms. Selalu resolve lewat `AppMotion.resolve(context, d)` agar mode reduced-motion dihormati (durasi menjadi nol).

## Aksesibilitas

- `AppTextScale` (`lib/core/a11y/text_scale.dart`) membatasi skala teks platform maksimum 1.6×; setiap layar harus bertahan di 1.6× tanpa terpotong.
- Target sentuh minimal 44pt lewat `TapTarget` (`lib/core/ui/tap_target.dart`).
- Kontras teks minimal WCAG AA 4.5:1 di kedua tema (DS-6).
