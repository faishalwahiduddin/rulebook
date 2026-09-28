import '../models/rule_category.dart';
import '../models/rule_item.dart';

class RulesDatabase {
  static const List<RuleItem> rules = [
    RuleItem(
      id: 'traffic-01',
      title: 'Batas Kecepatan Jalan Tol & Arteri',
      category: RuleCategory.traffic,
      summary: 'Batas kecepatan maksimal 100 km/jam di jalan tol bebas hambatan dan minimal 60 km/jam.',
      fullExplanation:
          'Setiap pengemudi wajib mematuhi rambu batas kecepatan. Di jalan tol luar kota batas maksimal adalah 100 km/jam dan minimal 60 km/jam. Di jalan tol dalam kota maksimal 80 km/jam. Di jalan antarkota maksimal 80 km/jam, kawasan perkotaan 50 km/jam, dan kawasan permukiman 30 km/jam.',
      legalBasis: 'UU No. 22 Tahun 2009 Pasal 287 ayat (5) jo. PP No. 79 Tahun 2013',
      penaltyOrRight: 'Denda maksimal Rp 500.000 atau pidana kurungan paling lama 2 bulan',
      keyDos: [
        'Perhatikan rambu batas kecepatan di setiap ruas jalan',
        'Jaga jarak aman antar kendaraan sesuai kecepatan (aturan 3 detik)'
      ],
      keyDonts: [
        'Memacu kendaraan di atas 100 km/jam di jalan tol',
        'Berjalan lambat di lajur paling kanan (lajur hanya untuk mendahului)'
      ],
      keywords: ['kecepatan', 'jalan tol', 'speed limit', 'tilang', 'km/jam', 'lajur kanan'],
    ),
    RuleItem(
      id: 'traffic-02',
      title: 'Larangan Menggunakan Ponsel Saat Berkendara',
      category: RuleCategory.traffic,
      summary: 'Dilarang mengoperasikan gawai atau melakukan kegiatan yang mengganggu konsentrasi saat mengemudi.',
      fullExplanation:
          'Pengemudi dilarang melakukan kegiatan yang mengakibatkan gangguan konsentrasi, termasuk mengetik pesan, melihat video, atau memegang telepon saat kendaraan bergerak.',
      legalBasis: 'UU No. 22 Tahun 2009 Pasal 283 jo. Pasal 106 ayat (1)',
      penaltyOrRight: 'Denda maksimal Rp 750.000 atau kurungan paling lama 3 bulan',
      keyDos: [
        'Gunakan holder GPS di dashboard dan atur rute sebelum mulai berjalan',
        'Tepikan kendaraan di tempat aman jika harus menerima telepon darurat'
      ],
      keyDonts: [
        'Membalas chat atau scrolling media sosial saat berhenti di lampu merah',
        'Menempelkan ponsel di telinga saat mengemudi'
      ],
      keywords: ['hp', 'ponsel', 'chat', 'telepon', 'konsentrasi', 'distraksi'],
    ),
    RuleItem(
      id: 'traffic-03',
      title: 'Kewajiban Membawa SIM & STNK Asli',
      category: RuleCategory.traffic,
      summary: 'Pengendara wajib memiliki SIM sah dan dapat menunjukkan STNK yang sah saat pemeriksaan.',
      fullExplanation:
          'Setiap orang yang mengemudikan kendaraan bermotor di jalan wajib memiliki SIM yang masih berlaku sesuai jenis kendaraannya dan membawa STNK asli yang sah.',
      legalBasis: 'UU No. 22 Tahun 2009 Pasal 281 (tidak punya SIM) & Pasal 288 ayat (1) (tidak bawa STNK)',
      penaltyOrRight: 'Tidak punya SIM: denda maks Rp 1.000.000; Tidak bawa STNK: denda maks Rp 500.000',
      keyDos: [
        'Periksa masa berlaku SIM dan pajak tahunan STNK secara berkala',
        'Bawa dokumen fisik atau tunjukkan dokumen digital resmi terintegrasi (Korlantas)'
      ],
      keyDonts: [
        'Mengemudi tanpa mengantongi SIM yang sah',
        'Meminjamkan kendaraan ke pengemudi di bawah umur / tanpa SIM'
      ],
      keywords: ['sim', 'stnk', 'razia', 'pemeriksaan', 'tilang polisi', 'dokumen berkendara'],
    ),
    RuleItem(
      id: 'traffic-04',
      title: 'Lampu Utama Sepeda Motor Siang Hari (Daytime Running Light)',
      category: RuleCategory.traffic,
      summary: 'Pengendara sepeda motor wajib menyalakan lampu utama pada siang dan malam hari.',
      fullExplanation:
          'Untuk meningkatkan visibilitas dan mencegah kecelakaan fatal, sepeda motor wajib menyalakan lampu utama di jalan pada siang hari maupun malam hari.',
      legalBasis: 'UU No. 22 Tahun 2009 Pasal 293 ayat (2) jo. Pasal 107 ayat (2)',
      penaltyOrRight: 'Denda maksimal Rp 100.000 atau pidana kurungan paling lama 15 hari',
      keyDos: [
        'Pastikan lampu dekat (low beam) menyala otomatis saat mesin dihidupkan',
        'Segera ganti bohlam lampu jika mati'
      ],
      keyDonts: [
        'Memasang saklar rahasia untuk mematikan lampu di siang hari',
        'Menggunakan lampu tembak menyilaukan (strobo/silau) yang melanggar standar'
      ],
      keywords: ['lampu motor', 'siang hari', 'drl', 'visibilitas', 'lampu utama'],
    ),
    RuleItem(
      id: 'labor-01',
      title: 'Batas Jam Kerja & Perhitungan Upah Lembur',
      category: RuleCategory.labor,
      summary: 'Maksimal 40 jam kerja per minggu. Lembur maksimal 4 jam/hari dan 18 jam/minggu dengan upah lembur resmi.',
      fullExplanation:
          'Waktu kerja standar adalah 7 jam/hari (6 hari kerja) atau 8 jam/hari (5 hari kerja). Kerja lembur wajib mendapat persetujuan tertulis pekerja. Upah lembur jam pertama dihitung 1,5x upah sejam, jam berikutnya 2x upah sejam.',
      legalBasis: 'PP No. 35 Tahun 2021 Pasal 21 & Pasal 26 jo. UU Cipta Kerja',
      penaltyOrRight: 'Hak upah lembur wajib dibayarkan perusahaan; pelanggaran diancam sanksi pidana denda',
      keyDos: [
        'Catat jam masuk dan keluar kerja lembur secara mandiri',
        'Pastikan ada perintah lembur resmi (Surat Perintah Lembur) dari atasan'
      ],
      keyDonts: [
        'Bekerja lembur melebihi batas 4 jam per hari atau 18 jam per minggu',
        'Menerima sistem lembur tanpa kompensasi upah resmi'
      ],
      keywords: ['jam kerja', 'lembur', 'upah lembur', 'pp 35', 'cipta kerja', 'karyawan'],
    ),
    RuleItem(
      id: 'labor-02',
      title: 'Hak Cuti Tahunan & Perlindungan Cuti Melahirkan',
      category: RuleCategory.labor,
      summary: 'Hak cuti tahunan minimal 12 hari kerja setelah 12 bulan masa kerja, cuti melahirkan 3-6 bulan tetap bergaji.',
      fullExplanation:
          'Pekerja yang telah bekerja 1 tahun berhak atas cuti tahunan sekurang-kurangnya 12 hari kerja dengan upah penuh. Pekerja perempuan berhak cuti melahirkan selama 3 bulan (atau hingga 6 bulan sesuai UU KIA) dengan jaminan upah tidak boleh dipotong.',
      legalBasis: 'UU No. 13 Tahun 2003 Pasal 79 jo. UU Kesejahteraan Ibu dan Anak (KIA) 2024',
      penaltyOrRight: 'Hak mutlak pekerja; pengusaha dilarang mem-PHK pekerja yang mengambil cuti sah',
      keyDos: [
        'Ajukan permohonan cuti tahunan sesuai prosedur internal perusahaan',
        'Lampirkan surat keterangan dokter untuk cuti melahirkan atau cuti sakit'
      ],
      keyDonts: [
        'Memotong hak cuti tahunan tanpa persetujuan pekerja',
        'Menyetujui klausula kontrak yang menghapus hak cuti tahunan'
      ],
      keywords: ['cuti tahunan', 'cuti melahirkan', 'uu kia', 'gaji penuh', 'hak pekerja'],
    ),
    RuleItem(
      id: 'privacy-01',
      title: 'Persetujuan Pemrosesan & Hak Hapus Data Pribadi',
      category: RuleCategory.privacy,
      summary: 'Pemrosesan data pribadi wajib memiliki persetujuan sah dan pemilik data berhak meminta penghapusan data.',
      fullExplanation:
          'Setiap pengendali data pribadi (aplikasi, bank, kantor) wajib memiliki dasar persetujuan eksplisit dari pemilik data. Pemilik data berhak menarik persetujuan, meminta koreksi, dan menuntut penghapusan (right to erasure) atas datanya.',
      legalBasis: 'UU No. 27 Tahun 2022 tentang Pelindungan Data Pribadi (UU PDP) Pasal 20 & Pasal 8',
      penaltyOrRight: 'Sanksi denda administratif hingga 2% dari pendapatan tahunan pengendali data dan sanksi pidana',
      keyDos: [
        'Gunakan watermark tujuan pada foto KTP/dokumen sebelum diunggah',
        'Minta bukti konfirmasi tertulis saat meminta penghapusan akun atau data pribadi'
      ],
      keyDonts: [
        'Memberikan persetujuan akses kontak/galeri pada aplikasi pinjol tanpa verifikasi',
        'Menyebarkan foto KTP atau data pribadi orang lain tanpa izin tertulis'
      ],
      keywords: ['pdp', 'data pribadi', 'ktp', 'privasi', 'uu pdp', 'hapus data'],
    ),
    RuleItem(
      id: 'consumer-01',
      title: 'Hak Penggantian Barang Rusak & Larangan Klausula Baku Sepihak',
      category: RuleCategory.consumer,
      summary: 'Konsumen berhak atas kompensasi barang cacat. Tulisan "Barang yang dibeli tidak dapat ditukar" adalah batal demi hukum.',
      fullExplanation:
          'Pelaku usaha dilarang mencantumkan klausula baku yang menyatakan tidak bertanggung jawab atas cacat barang atau menolak pengembalian barang yang tidak sesuai perjanjian. Konsumen berhak atas penggantian barang sejenis atau pengembalian uang.',
      legalBasis: 'UU No. 8 Tahun 1999 tentang Perlindungan Konsumen (UUPK) Pasal 18 jo. Pasal 19',
      penaltyOrRight: 'Klausula sepihak batal demi hukum; pelanggaran diancam pidana penjara 5 tahun atau denda Rp 2 Miliar',
      keyDos: [
        'Selalu simpan bukti pembelian, struk, dan video unboxing saat belanja online',
        'Lakukan komplain resmi ke layanan konsumen pelaku usaha atau BPSK (Badan Penyelesaian Sengketa Konsumen)'
      ],
      keyDonts: [
        'Menyerah saat toko menolak retur barang rusak dengan dalih "klausula tidak dapat ditukar"',
        'Merusak segel barang sebelum memastikan kelengkapan fungsi'
      ],
      keywords: ['konsumen', 'uupk', 'retur barang', 'klausula baku', 'cacat tersembunyi', 'garansi'],
    ),
    RuleItem(
      id: 'safety-01',
      title: 'SOP Evakuasi Kebakaran & Titik Kumpul (Assembly Point)',
      category: RuleCategory.safety,
      summary: 'Dilarang menggunakan lift saat alarm kebakaran berbunyi. Gunakan tangga darurat menuju titik kumpul.',
      fullExplanation:
          'Saat mendengar alarm kebakaran: tetap tenang, hentikan pekerjaan segera, jangan membawa barang berat, tutup pintu ruangan untuk memperlambat api, gunakan tangga darurat evakuasi, dan jangan pernah menggunakan lift listrik. Berkumpullah di titik kumpul (assembly point) untuk pendataan personel.',
      legalBasis: 'UU No. 1 Tahun 1970 tentang Keselamatan Kerja & Kepmenaker No. 186/1999',
      penaltyOrRight: 'Kewajiban standar K3 nasional untuk seluruh gedung perkantoran dan publik',
      keyDos: [
        'Hafalkan rute tangga darurat terdekat di tempat kerja Anda',
        'Raba pintu sebelum membuka; jika gagang panas, jangan dibuka'
      ],
      keyDonts: [
        'Menggunakan lift saat terjadi gempa atau kebakaran gedung',
        'Kembali masuk ke dalam gedung sebelum petugas pemadam menyatakan aman'
      ],
      keywords: ['k3', 'kebakaran', 'evakuasi', 'tangga darurat', 'titik kumpul', 'assembly point'],
    ),
  ];
}
