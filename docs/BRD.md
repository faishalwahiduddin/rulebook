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
