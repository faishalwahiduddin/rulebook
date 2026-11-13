# AGENTS.md — RuleBook (rulebook)

> Guidelines for AI agents working in this Flutter codebase.
> Workspace root: `../` · Canonical fleet guide: [`../AGENTS.md`](../AGENTS.md)

## Mulai di sini (60 detik)

<!-- trace:begin start-here -->
- **App**: `rulebook` (RuleBook) — RuleBook — Pocket Rules, Regulations & Guidelines: Buku saku aturan digital offline untuk referensi cepat peraturan lalu lintas, hak ketenagakerjaan, etika digital & privasi data, serta SOP penting.
- **Platform & jalankan**: Flutter Web (Cloudflare Pages `rulebook-faishal` → https://rulebook.faishal.id) + Android + iOS. `flutter run -d chrome` untuk web, `flutter run -d <device>` untuk mobile. applicationId: `id.faishal.rulebook`.
- **Branch**: `main` = default dan rilis.
- **Cek**: `flutter analyze && flutter test` sebelum commit — wajib nol peringatan.
- **CLI**: `gh-faishal` (remote `faishalwahiduddin/rulebook`) dan `wrangler-faishal` — jangan bare `gh`/`wrangler`.
- **Validasi (§VAL)**: Di setiap project tanpa kecuali, setiap input, form, dan mutation wajib divalidasi di frontend dan backend.
- **Versi (§VER)**: bump via `python3 ../tools/bump_version.py rulebook patch` (atau `minor`/`major`) sebelum commit kode di `lib/`/`assets`/platform. SSOT = `pubspec.yaml`; UI pakai `package_info_plus`. Detail: [`../../CLAUDE.md` §VER](../../CLAUDE.md#versioning-ver).
- **Larangan**: Jangan menjalankan dev server (`flutter run`) atau `flutter build` kecuali diminta secara eksplisit oleh pengguna.
<!-- trace:end -->

## Struktur repo (§ORG)

<!-- repo-layout:begin -->
- Root repo hanya **source code + konfigurasi**. Jangan membuat folder atau berkas baru di root (laporan, catatan, scratch, screenshot, ekspor).
- Rencana → `docs/plans/active/` (tuntas → `docs/plans/archive/`) · changelog → `docs/changelog/YYYY/MM/YYYY-MM-DD-<slug>.md` · test Playwright → `tests/e2e/` (Flutter: `test/`, `integration_test/`) · trace / openspec / store / QA / riset → `docs/<topik>/`.
- Screenshot & artefak QA (`test-results/`, `playwright-report/`, `qa-*`, `screenshots/`, bukti run) tidak pernah di-commit — sudah di-ignore lewat blok `repo-layout standard` di `.gitignore`.
- Berkas sementara → scratchpad sesi atau `/tmp`, bukan repo.
- Aturan lengkap: `~/projects/docs/standards.md` §ORG.
<!-- repo-layout:end -->

## Quick Commands

```bash
flutter run -d chrome                                       # Dev server (web)
flutter test                                                # Run all tests
flutter analyze                                             # Static analysis (run before every commit)
flutter build web --release                                 # Production web build
flutter build apk --release                                 # Android APK
flutter build appbundle --release                           # Android App Bundle (Play Store)
```

## Project Overview

**RuleBook** — Universal Pocket Rulebook & Statutes Companion: Buku saku pegangan aturan ringkas dan terstruktur (Aturan Berkendara & Tilang, Hak Ketenagakerjaan & Lembur, Perlindungan Konsumen, UU ITE & Privasi Data, SOP Darurat, Etika Publik). 100% offline, pencarian instan, dan penanda pasal favorit.

- **Ecosystem**: Utility & Knowledge Fleet
- **Subdomain**: https://rulebook.faishal.id
- **Application ID**: `id.faishal.rulebook`
- **Repository**: `faishalwahiduddin/rulebook`

## Domain Terminology

| Term (ID) | Term (EN) | Context |
|-----------|-----------|---------|
| Kategori Aturan | Rule Category | Klasifikasi domain aturan (Lalu Lintas, Ketenagakerjaan, Privasi/ITE, Konsumen, SOP) |
| Butir Aturan / Pasal | Rule Entry / Section | Ringkasan pokok aturan, dasar hukum resmi, dan sanksi/denda pelanggaran |
| Dasar Hukum | Legal Basis / Reference | Nomor UU, PP, Perpres, atau standar ISO/SOP terkait |
| Sanksi & Denda | Penalty & Fine | Batas denda maksimal atau sanksi administratif resmi |
| Bookmark / Simpan | Pinned Rule | Menyimpan aturan penting ke daftar akses cepat tanpa internet |

## Mandatory Rules

1. **Akses Cepat & Offline Total**: Semua konten aturan wajib tertanam secara lokal di aplikasi tanpa memerlukan koneksi internet untuk membaca.
2. **Pencarian Cerdas Instan**: Fitur pencarian wajib memfilter teks judul, kata kunci, nomor pasal, dan deskripsi secara real-time.
3. **Format Ringkas & Mudah Dipahami**: Menampilkan intisari "Apa yang boleh", "Apa yang dilarang", dan "Berapa sanksinya" dalam bahasa manusiawi tanpa menghilangkan rujukan dasar hukum formal.
4. **Tanpa backend, tanpa akun**: Aplikasi langsung siap dipakai tanpa registrasi, tanpa tracking data sensitif pengguna.

## Tech Stack
**Flutter 3.44.8 · Dart 3.12.2 · Riverpod 3.x · GoRouter · Cloudflare**

## Rules & Conventions
1. **Architecture: MVVM + Riverpod (feature-first)** di bawah `lib/features/` dan `lib/core/`.
2. **Offline-first**: Basis data aturan disimpan secara lokal di perangkat, dapat diakses instan tanpa jaringan.
3. **No dev servers**: Jangan jalankan dev server atau build kecuali diminta eksplisit.
4. **Validasi Wajib (§VAL)**: Setiap pencarian, filter, bookmark, dan catatan kustom wajib divalidasi dengan jelas.
5. **CLI Wrappers**: Gunakan `gh-faishal` dan `wrangler-faishal`.

### Design Systems

Sistem desain RuleBook terdokumentasi di:
- **SSOT Desain**: [`DESIGN.md`](./DESIGN.md) (pointer kanonik).
- **Panduan Token**: [`docs/reference/design-system/`](./docs/reference/design-system/) ([`foundations.md`](./docs/reference/design-system/foundations.md) + [`components.md`](./docs/reference/design-system/components.md)).
- **Implementasi Token**: [`lib/core/constants/app_colors.dart`](./lib/core/constants/app_colors.dart), [`lib/core/theme/app_colors.dart`](./lib/core/theme/app_colors.dart), [`lib/core/theme/app_icons.dart`](./lib/core/theme/app_icons.dart), [`lib/core/theme/app_theme.dart`](./lib/core/theme/app_theme.dart).

Aturan pengerjaan UI:
- Dilarang hardcode literal `Color(0x...)` di widget presentation; gunakan token yang terdokumentasi di `foundations.md`.
- Warna baru ditambahkan sebagai konstanta bernama di berkas token, bukan inline.
- Pertahankan dukungan tema terang/gelap, kontras WCAG AA, dan Dynamic Type hingga 1.6×.

<!-- jules-design-skills:begin -->
## Jules design skills (in-repo)

Before UI redesign work (including Jules cloud sessions), read and run:

1. `.agents/skills/impeccable/SKILL.md` — then:
   `.agents/skills/impeccable/scripts/impeccable context`
2. `.agents/skills/ui-ux-pro-max/SKILL.md` — then e.g.:
   `python3 .agents/skills/ui-ux-pro-max/scripts/search.py "<query>" --stack flutter`
   Use `--design-system` for product-wide direction.

These trees are committed so remote agents (Jules) can load them after clone.
<!-- jules-design-skills:end -->

<!-- mascot-sheet:begin -->
## Mascot sheet (50 poses + 50 expressions)

The full character sheet for **Bubu** (burung hantu kerdil (pygmy owl)) lives **outside this repo** in the fleet library
`../docs/mascots/sheets/rulebook/` (`~/projects/faishal.id/docs/mascots/sheets/rulebook/`). It is on this machine
only, not in git and not in the app bundle.

- `poses/pose-NN-<id>.png` (01 to 50) and `expressions/expr-NN-<id>.png` (01 to 50): transparent RGBA 1024x1024.
- `README.md` there: an index of every file (ID, what it shows, QA result). Pick a pose from it by meaning.
- Pose and expression lists: `../tools/mascot_kits/catalog.py`. How the sheet was made: `../tools/mascot_kits/README.md`.
- Known gaps: none.

To use one in the app:
1. Copy only the files `lib/` uses into `assets/mascot/poses/` or `assets/mascot/expressions/` (keep the file name).
   Downscale to 512 px when shown small. Never copy the whole sheet (about 50 MB).
2. List each new subfolder under `flutter: assets:` in `pubspec.yaml`: `assets/mascot/` does not include subfolders.
3. Bump the version (§VER) from the fleet root: `python3 tools/bump_version.py rulebook minor`.
<!-- mascot-sheet:end -->
