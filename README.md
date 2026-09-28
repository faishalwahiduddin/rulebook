# RuleBook

> RuleBook — Pocket Rules, Regulations & Guidelines: Buku saku digital offline untuk referensi cepat aturan sehari-hari (lalu lintas, hak kerja, privasi data, dan kepatuhan publik).

Part of the **faishal.id** fleet (Utility & Knowledge Series).

- **Production / Web**: https://rulebook.faishal.id
- **Application ID**: `id.faishal.rulebook`
- **Repository**: private `faishalwahiduddin/rulebook`

## Tech Stack
- **Framework**: [Flutter](https://flutter.dev) (Web, Android, iOS)
- **Language**: [Dart](https://dart.dev)
- **State Management**: [Riverpod](https://riverpod.dev)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
- **Platform Deploy**: Cloudflare Pages (`rulebook-faishal`)

## Fitur Utama / Key Features
1. **100% Offline-First**: Seluruh basis data aturan tersimpan lokal di perangkat, langsung terbuka tanpa jeda loading atau kuota.
2. **Kategori Aturan Komprehensif**:
   - Aturan Lalu Lintas & Batas Denda Tilang (UU LLAJ)
   - Hak Tenaga Kerja & Jam Lembur (UU Ketenagakerjaan & Cipta Kerja)
   - Perlindungan Data Pribadi & ITE (UU PDP & UU ITE)
   - Hak Konsumen & Transaksi Elektronik
   - SOP Darurat & Keselamatan Kerja (K3)
3. **Pencarian Cepat & Filter Kategori**: Cari berdasarkan kata kunci, topik, atau pasal hukum.
4. **Penanda Favorit (Bookmarks)**: Simpan aturan yang sering dibutuhkan untuk referensi instan.
5. **Kalkulator / Simulator Denda & Hak**: Simulasi cepat besaran hak atau sanksi aturan.

## Getting Started

```bash
flutter pub get
flutter test
flutter analyze
```

## Agent Guides
- [`AGENTS.md`](./AGENTS.md) — Comprehensive guide for AI coding agents.
- [`CLAUDE.md`](./CLAUDE.md) — Quick developer reference.
- [`GEMINI.md`](./GEMINI.md) — Antigravity & Gemini instructions.

## License
Private repository © Faishal Wahiduddin. All rights reserved.
