# CLAUDE.md — RuleBook

## Overview
RuleBook — Pocket Rules, Regulations & Guidelines: Buku saku aturan digital offline untuk referensi cepat peraturan lalu lintas, hak ketenagakerjaan, etika digital & privasi data, serta SOP penting. **100% offline-first, tanpa backend, tanpa akun.**
Bahasa Indonesia & English supported.

**Subdomain:** rulebook.faishal.id · **CF Project:** `rulebook-faishal` · **appId:** `id.faishal.rulebook`
**Git remote:** `git@github.com:faishalwahiduddin/rulebook.git`

## Tech Stack
**Flutter 3.44.8 · Dart 3.12.2 · Riverpod 3.x · GoRouter · Cloudflare**

## Quick Commands
```bash
flutter run -d chrome                                       # Dev server (web)
flutter test                                                # Run all tests
flutter analyze                                             # Static analysis
flutter build web --release                                 # Production web build
flutter build appbundle --release                           # Android App Bundle
```

## Rules & Conventions
1. **Architecture: MVVM + Riverpod (feature-first)** di bawah `lib/features/` dan `lib/core/`.
2. **Offline-first**: Basis data aturan disimpan secara lokal di perangkat, dapat diakses instan tanpa jaringan.
3. **No dev servers**: Jangan jalankan dev server atau build kecuali diminta eksplisit.
4. **Validasi Wajib (§VAL)**: Setiap pencarian, filter, bookmark, dan catatan kustom wajib divalidasi dengan jelas.
5. **CLI Wrappers**: Gunakan `gh-faishal` dan `wrangler-faishal`.
