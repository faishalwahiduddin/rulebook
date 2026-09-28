# GEMINI.md

This file provides guidance to Gemini / Antigravity when working in this repository.

> **Full context lives in `AGENTS.md`** — read it before doing anything.

## Quick Commands
```bash
flutter test                                                # Run all tests
flutter analyze                                             # Static analysis (run before committing)
flutter build web --release                                 # Production web build
flutter build appbundle --release                           # Android App Bundle
```

## Key Notes
- **RuleBook** — Pocket Rules, Regulations & Guidelines: Buku saku aturan digital offline untuk referensi cepat peraturan lalu lintas, hak kerja, privasi data, dan SOP.
- Subdomain: https://rulebook.faishal.id
- Application ID: `id.faishal.rulebook`
- Clean architecture: MVVM + Riverpod + GoRouter (feature-first).
- Always run `flutter test` and `flutter analyze` before committing.
- Respect fleet conventions from `../AGENTS.md`.
