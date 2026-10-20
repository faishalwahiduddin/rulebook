# BRD — RuleBook

> Batas SSOT. Dokumen ini milik **WHY dan WHAT tingkat bisnis**: tujuan,
> aktor, glosarium, dan aturan bisnis RuleBook. Alur rinci per fitur,
> katalog validasi, dan kriteria terima ada di [PRD](./PRD.md).

- App: `rulebook` — buku saku aturan: lalin, ketenagakerjaan, ITE,
  konsumen, SOP. Offline total.
- Stack: Flutter 3.x, Riverpod, GoRouter, SharedPreferences.
- Subdomain: rulebook.faishal.id · appId: `id.faishal.rulebook`.
- Repo: `faishalwahiduddin/rulebook`. Aturan: [AGENTS.md](../AGENTS.md).

## 1. Tujuan dan latar

RuleBook ada agar orang awam bisa tahu hak, kewajiban, dan sanksinya
dalam hitungan detik, dengan bahasa manusiawi dan rujukan hukum yang
bisa diverifikasi. Tanpa internet, tanpa daftar, tanpa biaya.

Nilai yang diimplementasikan:

1. **Cepat saat dibutuhkan.** Pencarian instan menjangkau judul, kata
   kunci, dan nomor pasal sekaligus.
2. **Manusiawi tapi sah.** Intisari boleh/dilarang/sanksi ditulis ringan
   tanpa menghilangkan dasar hukum formal.
3. **Selalu tersedia.** Seluruh konten tertanam lokal; jalan penuh saat
   offline di jalan atau daerah minim sinyal.
4. **Favorit siap buka.** Pasal penting ditandai dan dibuka dalam dua tap.

Di luar lingkup: konsultasi hukum personal, update regulasi otomatis,
backend atau akun.

## 2. Aktor dan peran

| Aktor | Sifat | Kemampuan |
|---|---|---|
| Masyarakat | Tanpa akun | Baca, cari, bookmark, bagikan butir aturan |

Satu aktor saja; tidak ada peran berbasis server.

## 3. Glosarium domain

- **Kategori aturan.** Klasifikasi domain: lalu lintas, ketenagakerjaan,
  privasi/ITE, konsumen, SOP darurat.
- **Butir aturan/pasal.** Ringkasan pokok aturan, dasar hukum resmi, dan
  sanksi atau denda pelanggaran.
- **Dasar hukum.** Nomor UU, PP, Perpres, atau standar terkait.
- **Sanksi dan denda.** Batas denda maksimal atau sanksi administratif.
- **Bookmark.** Aturan favorit yang disimpan untuk akses cepat offline.

## 4. Aturan bisnis

1. Semua konten aturan wajib tertanam lokal; tidak ada pengambilan konten
   dari jaringan saat dibaca.
2. Ringkasan tidak boleh mengubah makna norma dalam dokumen sumbernya.
3. Setiap butir wajib mencantumkan dasar hukum formal yang bisa dicek.
4. Aplikasi memuat penafian bahwa isinya ringkasan informasi, bukan
   nasihat hukum profesional.
5. Tanpa backend, tanpa akun, tanpa tracking data pengguna.
6. Update regulasi mengikuti rilis aplikasi; konten lama tidak diubah
   diam-diam tanpa versi.

## 5. Risiko dan batasan

- Regulasi berubah; konten perlu tinjau berkala tiap rilis.
- Perbedaan interpretasi pasal perlu dirujuk ke teks asli, bukan
   diputuskan aplikasi.

## 6. Kebutuhan bisnis (§TRACE)

ID di kolom pertama adalah SSOT `BR-NNN`; kolom terakhir menunjuk kebutuhan
produk di [PRD](./PRD.md) yang merealisasikannya.

| ID | Kebutuhan bisnis | Direalisasikan oleh |
|---|---|---|
| BR-001 | Cepat saat dibutuhkan: orang awam menemukan aturan, pasal, dan sanksinya dalam hitungan detik. | FR-001, FR-004, NFR-002 |
| BR-002 | Manusiawi tapi sah: intisari boleh/dilarang/sanksi ditulis ringan tanpa menghilangkan dasar hukum formal; bisa dibagikan apa adanya. | FR-002, FR-003, FR-007, FR-011 |
| BR-003 | Selalu tersedia: seluruh konten tertanam lokal dan jalan penuh saat offline. | NFR-001 |
| BR-004 | Favorit siap buka: pasal penting dan catatan pribadi dibuka kembali dalam dua tap. | FR-005, FR-006 |
| BR-005 | Panduan bertindak: SOP darurat, audit kepatuhan, dan kalkulator hak (lembur, pesangon) melengkapi bacaan aturan. | FR-008, FR-009, FR-010 |
| BR-006 | Data pribadi milik pengguna: tanpa akun dan tracking; simpanan bisa dicadangkan, dipulihkan, dan dihapus sendiri. | FR-012 |
| BR-007 | Penafian: aplikasi menyatakan isinya ringkasan informasi, bukan nasihat hukum profesional. | FR-013 |
