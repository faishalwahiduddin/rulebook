# PRD: RuleBook — Buku Saku Aturan dan Regulasi

## 1. Overview

**RuleBook** adalah buku saku aturan digital: ringkasan peraturan lalu
lintas, hak ketenagakerjaan, UU ITE dan privasi data, perlindungan
konsumen, serta SOP penting. 100% offline dengan pencarian instan dan
penanda pasal favorit.

- **Subdomain**: rulebook.faishal.id
- **CF Project**: `rulebook-faishal` · **appId**: `id.faishal.rulebook`
- **Platform**: Web, Android, iOS
- **Repository**: `faishalwahiduddin/rulebook`

## 2. Problem Statement

1. **Aturan sulit dicari cepat.** Saat tilang atau sengketa, orang tidak
   tahu pasal dan dendanya dalam hitungan detik.
2. **Bahasa hukum berat.** UU dan PP sulit dipahami orang awam dalam
   situasi tertekan.
3. **Internet tidak selalu ada.** Referensi online tidak bisa diandalkan
   di jalan atau di daerah minim sinyal.

## 3. Target Users

- Pengendara yang ingin tahu aturan dan denda tilang
- Pekerja yang ingin tahu hak ketenagakerjaan dan lembur
- Masyarakat umum untuk UU ITE, privasi data, dan perlindungan konsumen

## 4. Features

### 4.1 MVP

| Kode | Fitur | SP | Deskripsi | Lokasi kode |
|---|---|:---:|---|---|
| `US-001` | **Shell + kategori** | 2 | Beranda + klasifikasi domain aturan | `lib/features/` |
| `US-002` | **Butir aturan** | 5 | Ringkasan + dasar hukum + sanksi | `lib/features/` |
| `US-003` | **Pencarian instan** | 3 | Filter teks, kata kunci, nomor pasal | `lib/features/` |
| `US-004` | **Bookmark** | 2 | Pasal favorit akses cepat offline | `lib/features/` |
| `US-005` | **Format manusiawi** | 3 | Boleh/dilarang/sanksi tanpa hilangkan rujukan | `lib/core/` |
| `US-006` | **Konten bawaan** | 5 | Lalin, ketenagakerjaan, ITE, konsumen, SOP | `lib/core/` |
| `US-007` | **Share butir** | 2 | Bagikan ringkasan via share_plus | `lib/features/` |
| `US-008` | **i18n** | 3 | 8 bahasa (id, en, ar, jv, su, zh, ja, es) | `lib/l10n/` |
| `US-009` | **Kalkulator hak** | 5 | Upah lembur, pesangon PHK, THR prorata, denda tilang, sanksi ITE | `lib/features/calculator/` |
| `US-010` | **SOP darurat** | 3 | Langkah bernomor + kontak darurat + dasar hukum | `lib/features/sop/` |
| `US-011` | **Audit kepatuhan** | 3 | Checklist per modul, progres tersimpan, reset | `lib/features/checklist/` |
| `US-012` | **Pengaturan & cadangan** | 3 | Tema, bahasa, zona waktu, ekspor/pulihkan `.rlb`, hapus data, penafian | `lib/features/settings/` |

### 4.2 Di luar cakupan

- Konsultasi hukum personal atau bantuan perkara
- Update regulasi otomatis dari server (konten ikut rilis app)
- Backend, akun, pelacakan pengguna

### 4.3 Kebutuhan produk (§TRACE)

`FR`/`NFR` di kolom pertama adalah SSOT; kolom berikutnya menunjuk `BR` asal
([BRD](./BRD.md)) dan story/flow yang merealisasikannya
([user-flows](./reference/specs/user-flows.md)).

| ID | Kebutuhan | Asal | Realisasi |
|---|---|---|---|
| FR-001 | Katalog menampilkan semua butir dengan jumlahnya dan menyaring per kategori (Lalu Lintas, Kerja, Data & ITE, Konsumen, K3, Etika). | BR-001 | US-001, FLOW-RUL-01 |
| FR-002 | Detail butir menampilkan dasar hukum, konsekuensi/sanksi, intisari, daftar Lakukan dan Hindari; tautan butir yang tidak ada menampilkan layar "tidak ditemukan". | BR-002 | US-002, US-005, FLOW-RUL-01 |
| FR-003 | Setiap butir bawaan wajib punya judul, ringkasan, dasar hukum, dan sanksi/hak di semua bahasa. | BR-002 | US-006, FLOW-RUL-01 |
| FR-004 | Pencarian instan di judul, ringkasan, dasar hukum (nomor pasal), dan kata kunci; maksimal 60 karakter; hasil kosong menawarkan **Atur ulang**. | BR-001 | US-003, FLOW-RUL-02 |
| FR-005 | Bookmark butir aturan (toggle) tanpa duplikat, tersimpan lokal, tampil di tab Simpanan. | BR-004 | US-004, FLOW-BKM-01 |
| FR-006 | Catatan pribadi per butir: wajib berisi, maksimal 500 karakter, bisa dikosongkan. | BR-004 | US-004, FLOW-BKM-01 |
| FR-007 | Bagikan kartu aturan (gambar) atau salin teks ringkasan yang memuat dasar hukum dan tautan app. | BR-002 | US-007, FLOW-RUL-03 |
| FR-008 | Kalkulator upah lembur, pesangon PHK (PP 35/2021), THR, denda tilang, dan sanksi ITE dengan validasi gaji Rp100.000–Rp1 miliar, jam lembur 0–100, masa kerja 0–60 tahun / 0–11 bulan. | BR-005 | US-009, FLOW-CAL-01 |
| FR-009 | SOP darurat per skenario: langkah bernomor, ringkasan hak, kontak darurat, dasar hukum. | BR-005 | US-010, FLOW-SOP-01 |
| FR-010 | Audit kepatuhan: centang butir, persentase kepatuhan per modul tersimpan lokal, reset per modul. | BR-005 | US-011, FLOW-AUD-01 |
| FR-011 | Antarmuka tersedia dalam 8 bahasa; tema sistem/terang/gelap tersimpan. | BR-002 | US-008, FLOW-SET-01 |
| FR-012 | Ekspor dan pulihkan cadangan `.rlb` (bookmark + catatan); berkas rusak/asing ditolak; hapus semua simpanan tanpa menghapus preferensi. | BR-006 | US-012, FLOW-SET-01 |
| FR-013 | Penafian "bukan nasihat hukum" tampil di Pengaturan. | BR-007 | US-012, FLOW-SET-01 |
| NFR-001 | Offline total: konten tertanam, tanpa request jaringan saat membaca. | BR-003 | FLOW-RUL-01 |
| NFR-002 | Pencarian mengembalikan hasil < 1 detik (filter lokal di memori). | BR-001 | FLOW-RUL-02 |

## 5. Data Model

| Model | Isi |
|---|---|
| `RuleCategory` | id, name, icon, description |
| `RuleEntry` | id, categoryId, title, summary, legalBasis, penalty |
| `Bookmark` | ruleId, createdAt |

Konten aturan tertanam lokal di aplikasi. Bookmark pengguna di
`shared_preferences`. Validasi §VAL untuk bookmark dan pencarian.

## 6. User Flows

1. **Cek tilang.** Buka kategori lalu lintas → cari pelanggaran →
   baca denda maksimal + dasar hukumnya dalam 30 detik.
2. **Cek hak.** Buka ketenagakerjaan → cari topik (lembur, PHK) →
   baca intisari + rujukan UU-nya.
3. **Simpan favorit.** Tandai pasal penting → buka dari daftar bookmark
   tanpa mencari ulang.
4. **Bagikan.** Kirim ringkasan butir ke teman via chat.

## 7. Validasi (§VAL)

- Setiap butir wajib punya judul, ringkasan, dan dasar hukum resmi.
- Nomor pasal/ayat wajib format konsisten sesuai dokumen sumber.
- Kata kunci pencarian wajib non-kosong; hasil kosong menampilkan saran.
- Bookmark ganda untuk butir yang sama tidak boleh dobel.
- Konten tidak boleh mengubah makna norma aslinya saat diringkas.

## 8. Acceptance Criteria

- [ ] Pencarian mengembalikan hasil relevan dalam < 1 detik.
- [ ] Seluruh konten bisa dibaca dalam mode pesawat.
- [ ] Setiap butir menampilkan dasar hukum formal yang bisa diverifikasi.
- [ ] `flutter analyze` nol peringatan, `flutter test` hijau.
- [ ] Ada penafian: ringkasan bukan nasihat hukum profesional.

## 9. Technical Constraints

- Akses cepat dan offline total; konten tertanam di app.
- Tanpa backend, tanpa akun, tanpa tracking.
- MVVM + Riverpod + GoRouter feature-first.
- CLI: `gh-faishal`, `wrangler-faishal`.
- Version: `python3 ../tools/bump_version.py rulebook patch`.
