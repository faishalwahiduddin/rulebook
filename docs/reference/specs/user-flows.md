# User flows — RuleBook

> Narasi per flow (SSOT nama/role/modul: `docs/reference/system/traceability.json`; case uji: `docs/trace/flows.yaml`;
> panduan BAST: `docs/client/bast/guide/`). Matriks lengkap: `docs/reference/system/traceability-matrix.md`.

## FLOW-RUL-01 — Menelusuri kategori dan membaca butir aturan

- Role: USR (`ROL-001`) · Modul: `MOD-001` · Story: US-001, US-002, US-005, US-006 · Kebutuhan: FR-001, FR-002, FR-003, NFR-001

1. Buka app (onboarding pertama kali → **Lewati**).
2. Pilih chip kategori di layar **Aturan**.
3. Ketuk kartu butir → detail: dasar hukum, konsekuensi, intisari, Lakukan/Hindari.
4. Tautan butir yang tidak ada → layar "tidak ditemukan" + **Kembali ke aturan**.

## FLOW-RUL-02 — Mencari aturan secara instan

- Role: USR (`ROL-001`) · Modul: `MOD-001` · Story: US-003 · Kebutuhan: FR-004, NFR-002

1. Ketik kata kunci/nomor pasal di kolom **Cari aturan, pasal, atau situasi...** atau ketuk chip cepat.
2. Daftar tersaring seketika; **Bersihkan pencarian** / **Atur ulang** mengembalikan semua butir.

## FLOW-RUL-03 — Membagikan butir aturan

- Role: USR (`ROL-001`) · Modul: `MOD-001` · Story: US-007 · Kebutuhan: FR-007

1. Di detail butir ketuk **Bagikan Kartu Aturan**.
2. Pilih rasio & tema; unduh/bagikan gambar atau **Salin Teks**.

## FLOW-BKM-01 — Menyimpan aturan dan catatan pribadi

- Role: USR (`ROL-001`) · Modul: `MOD-002` · Story: US-004 · Kebutuhan: FR-005, FR-006

1. Di detail butir ketuk ikon **Simpan aturan**.
2. Tulis **Catatan Pribadi** (≤500 karakter) → **Simpan**.
3. Buka tab **Simpanan** untuk aturan & catatan tersimpan.

## FLOW-CAL-01 — Menghitung estimasi upah lembur dan pesangon

- Role: USR (`ROL-001`) · Modul: `MOD-003` · Story: US-009 · Kebutuhan: FR-008

1. Ketuk tab **Hitung** → **Upah Lembur**.
2. Isi gaji pokok dan jam lembur; estimasi dihitung otomatis.
3. Aktifkan hari libur atau pindah ke **Pesangon PHK**.

## FLOW-SOP-01 — Membuka SOP darurat

- Role: USR (`ROL-001`) · Modul: `MOD-004` · Story: US-010 · Kebutuhan: FR-009

1. Ketuk tab **Darurat**.
2. Pilih SOP → ikuti langkah bernomor, hak, dan kontak darurat.

## FLOW-AUD-01 — Menjalankan audit kepatuhan

- Role: USR (`ROL-001`) · Modul: `MOD-005` · Story: US-011 · Kebutuhan: FR-010

1. Ketuk tab **Audit** → pilih modul.
2. Centang butir terpenuhi; persentase kepatuhan naik dan tersimpan.
3. **Reset Checklist** mengosongkan modul.

## FLOW-SET-01 — Mengatur bahasa, tema, dan cadangan data

- Role: USR (`ROL-001`) · Modul: `MOD-006` · Story: US-008, US-012 · Kebutuhan: FR-011, FR-012, FR-013

1. Ketuk **Pengaturan & Privasi** di layar Aturan.
2. Pilih tema, bahasa, zona waktu.
3. Ekspor/pulihkan cadangan `.rlb` atau hapus semua simpanan; baca penafian hukum.
