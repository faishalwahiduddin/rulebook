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
- **Larangan**: Jangan menjalankan dev server (`flutter run`) atau `flutter build` kecuali diminta secara eksplisit oleh pengguna.
<!-- trace:end -->

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
