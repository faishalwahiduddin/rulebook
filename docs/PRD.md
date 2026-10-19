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
| `US-008` | **i18n** | 3 | Indonesia + Inggris | `lib/l10n/` |

### 4.2 Di luar cakupan

- Konsultasi hukum personal atau bantuan perkara
- Update regulasi otomatis dari server (konten ikut rilis app)
- Backend, akun, pelacakan pengguna

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
