import '../models/compliance_checklist.dart';
import '../models/rule_category.dart';
import '../models/rule_item.dart';
import '../models/sop_guide.dart';

class RulesDatabase {
  static const List<RuleItem> rules = [
    // --- LALU LINTAS (TRAFFIC) ---
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
        'Jaga jarak aman antar kendaraan sesuai kecepatan (aturan 3 detik)',
      ],
      keyDonts: [
        'Memacu kendaraan di atas 100 km/jam di jalan tol',
        'Berjalan lambat di lajur paling kanan (lajur hanya untuk mendahului)',
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
        'Tepikan kendaraan di tempat aman jika harus menerima telepon darurat',
      ],
      keyDonts: [
        'Membalas chat atau scrolling media sosial saat berhenti di lampu merah',
        'Menempelkan ponsel di telinga saat mengemudi',
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
        'Bawa dokumen fisik atau tunjukkan dokumen digital resmi terintegrasi (Korlantas)',
      ],
      keyDonts: [
        'Mengemudi tanpa mengantongi SIM yang sah',
        'Meminjamkan kendaraan ke pengemudi di bawah umur / tanpa SIM',
      ],
      keywords: ['sim', 'stnk', 'razia', 'pemeriksaan', 'tilang polisi', 'dokumen berkendara'],
    ),
    RuleItem(
      id: 'traffic-04',
      title: 'Lampu Utama Sepeda Motor Siang Hari (DRL)',
      category: RuleCategory.traffic,
      summary: 'Pengendara sepeda motor wajib menyalakan lampu utama pada siang dan malam hari.',
      fullExplanation:
          'Untuk meningkatkan visibilitas dan mencegah kecelakaan fatal, sepeda motor wajib menyalakan lampu utama di jalan pada siang hari maupun malam hari.',
      legalBasis: 'UU No. 22 Tahun 2009 Pasal 293 ayat (2) jo. Pasal 107 ayat (2)',
      penaltyOrRight: 'Denda maksimal Rp 100.000 atau pidana kurungan paling lama 15 hari',
      keyDos: [
        'Pastikan lampu dekat (low beam) menyala otomatis saat mesin dihidupkan',
        'Segera ganti bohlam lampu jika mati',
      ],
      keyDonts: [
        'Memasang saklar rahasia untuk mematikan lampu di siang hari',
        'Menggunakan lampu tembak menyilaukan (strobo/silau) yang melanggar standar',
      ],
      keywords: ['lampu motor', 'siang hari', 'drl', 'visibilitas', 'lampu utama'],
    ),
    RuleItem(
      id: 'traffic-05',
      title: 'Helm Berstandar Nasional Indonesia (SNI)',
      category: RuleCategory.traffic,
      summary: 'Pengendara sepeda motor dan penumpangnya wajib mengenakan helm yang memenuhi standar SNI.',
      fullExplanation:
          'Setiap orang yang mengemudikan sepeda motor dan penumpang sepeda motor wajib mengenakan helm standar nasional Indonesia (SNI) terkunci dengan tali pengikat dagu yang benar (klik).',
      legalBasis: 'UU No. 22 Tahun 2009 Pasal 291 ayat (1) & ayat (2)',
      penaltyOrRight: 'Denda maksimal Rp 250.000 atau kurungan paling lama 1 bulan',
      keyDos: [
        'Pastikan logo SNI timbul (emboss) pada batok helm',
        'Kaitkan tali helm hingga berbunyi "klik" sebelum mulai berkendara',
      ],
      keyDonts: [
        'Mengenakan helm proyek atau helm sepeda santai untuk mengendarai motor',
        'Membiarkan tali helm menggantung tanpa dikunci',
      ],
      keywords: ['helm', 'sni', 'pengaman kepala', 'motor', 'tilang'],
    ),
    RuleItem(
      id: 'traffic-06',
      title: 'Larangan Melawan Arus Lalu Lintas',
      category: RuleCategory.traffic,
      summary: 'Dilarang mengemudikan kendaraan melawan arah arus lalu lintas yang telah ditentukan rambu.',
      fullExplanation:
          'Melawan arus membahayakan keselamatan umum secara ekstrem dan menjadi penyebab fatalitas kecelakaan lalu lintas tertinggi.',
      legalBasis: 'UU No. 22 Tahun 2009 Pasal 287 ayat (1)',
      penaltyOrRight: 'Denda maksimal Rp 500.000 atau kurungan paling lama 2 bulan',
      keyDos: [
        'Patuhi rambu satu arah (one-way) dan panah petunjuk jalan',
        'Pilih putaran balik resmi meskipun berjarak agak jauh demi keselamatan',
      ],
      keyDonts: [
        'Melawan arus di jalur sempit, trotoar, atau bahu jalan layang',
        'Mengikuti pengendara lain yang nekat menerobos jalur berlawanan',
      ],
      keywords: ['lawan arus', 'arah berlawanan', 'one way', 'rambu', 'bahaya'],
    ),
    RuleItem(
      id: 'traffic-07',
      title: 'Larangan Menerobos Jalur Busway (TransJakarta)',
      category: RuleCategory.traffic,
      summary: 'Kendaraan pribadi dilarang melintasi atau memasuki jalur khusus angkutan umum (Busway).',
      fullExplanation:
          'Jalur khusus busway steril hanya untuk armada TransJakarta dan kendaraan darurat yang diizinkan undang-undang (ambulan, pemadam kebakaran).',
      legalBasis: 'UU No. 22 Tahun 2009 Pasal 287 ayat (1) jo. Perda DKI No. 8/2007',
      penaltyOrRight: 'Denda maksimal tilang Rp 500.000 atau kurungan paling lama 2 bulan',
      keyDos: [
        'Tetap melaju di jalur reguler meskipun kondisi lalu lintas padat',
        'Beri jalan saat armada busway bermanuver di persimpangan',
      ],
      keyDonts: [
        'Memasuki jalur busway untuk menghindari antrean macet',
        'Berhenti atau parkir di depan portal jalur busway',
      ],
      keywords: ['busway', 'transjakarta', 'jalur khusus', 'steril', 'tilang etle'],
    ),
    RuleItem(
      id: 'traffic-08',
      title: 'Knalpot Bising & Standar Kelaikan Teknis',
      category: RuleCategory.traffic,
      summary: 'Kendaraan bermotor wajib memenuhi ambang batas kebisingan suara dan kelayakan teknis jalan.',
      fullExplanation:
          'Penggunaan knalpot brong/bising tanpa peredam suara melanggar standar kebisingan desibel Kementerian Lingkungan Hidup dan Kehutanan serta standar kelayakan kendaraan.',
      legalBasis: 'UU No. 22 Tahun 2009 Pasal 285 ayat (1) & Peraturan Menteri LHK No. 56 Tahun 2019',
      penaltyOrRight: 'Denda maksimal Rp 250.000 atau kurungan paling lama 1 bulan',
      keyDos: [
        'Gunakan knalpot standar pabrikan atau yang memiliki sertifikasi desibel resmi',
        'Lakukan uji emisi dan servis berkala',
      ],
      keyDonts: [
        'Memasang knalpot pipa terbuka (knalpot brong) di jalan umum permukiman',
        'Melepas spion, lampu sein, atau komponen keselamatan demi estetika balap liar',
      ],
      keywords: ['knalpot', 'knalpot brong', 'kebisingan', 'suara bising', 'razia knalpot'],
    ),

    // --- KETENAGAKERJAAN (LABOR) ---
    RuleItem(
      id: 'labor-01',
      title: 'Batas Jam Kerja & Perhitungan Upah Lembur',
      category: RuleCategory.labor,
      summary: 'Maksimal 40 jam kerja per minggu. Lembur maksimal 4 jam/hari dan 18 jam/minggu dengan upah lembur resmi.',
      fullExplanation:
          'Waktu kerja standar adalah 7 jam/hari (6 hari kerja) atau 8 jam/hari (5 hari kerja). Kerja lembur wajib mendapat persetujuan tertulis pekerja. Upah lembur jam pertama dihitung 1,5x upah sejam, jam berikutnya 2x upah sejam.',
      legalBasis: 'PP No. 35 Tahun 2021 Pasal 21 & Pasal 26 jo. UU Cipta Kerja',
      penaltyOrRight: 'Hak upah lembur wajib dibayarkan perusahaan; sanksi denda pidana bagi pengusaha pelanggar',
      keyDos: [
        'Catat jam masuk dan keluar kerja lembur secara mandiri',
        'Pastikan ada perintah lembur resmi (Surat Perintah Lembur) dari atasan',
      ],
      keyDonts: [
        'Bekerja lembur melebihi batas 4 jam per hari atau 18 jam per minggu',
        'Menerima sistem lembur tanpa kompensasi upah resmi',
      ],
      keywords: ['jam kerja', 'lembur', 'upah lembur', 'pp 35', 'cipta kerja', 'karyawan'],
    ),
    RuleItem(
      id: 'labor-02',
      title: 'Hak Cuti Tahunan & Hak Cuti Berbayar',
      category: RuleCategory.labor,
      summary: 'Pekerja berhak atas cuti tahunan sekurang-kurangnya 12 hari kerja setelah bekerja 12 bulan secara terus-menerus.',
      fullExplanation:
          'Pengusaha wajib memberikan cuti tahunan sekurang-kurangnya 12 hari kerja dengan upah penuh kepada pekerja yang telah bekerja selama 12 bulan terus-menerus. Cuti melahirkan diberikan 1,5 bulan sebelum dan 1,5 bulan sesudah melahirkan.',
      legalBasis: 'UU No. 13 Tahun 2003 Pasal 79 & UU No. 6 Tahun 2023 (UU Cipta Kerja)',
      penaltyOrRight: 'Hak mutlak pekerja berbayar penuh; denda sanksi administratif dan pidana kurungan bagi pengusaha',
      keyDos: [
        'Ajukan rencana cuti tahunan sesuai mekanisme internal perusahaan',
        'Simpan bukti persetujuan cuti dan sisa saldo cuti resmi',
      ],
      keyDonts: [
        'Mengurangi gaji pokok pekerja karena mengambil hak cuti resmi',
        'Menghanguskan saldo cuti tahunan tanpa mekanisme kompensasi tertulis',
      ],
      keywords: ['cuti tahunan', 'cuti melahirkan', 'hak cuti', 'libur', 'upah penuh'],
    ),
    RuleItem(
      id: 'labor-03',
      title: 'Tunjangan Hari Raya (THR) Keagamaan',
      category: RuleCategory.labor,
      summary: 'THR Keagamaan wajib dibayarkan penuh paling lambat 7 hari (H-7) sebelum hari raya keagamaan.',
      fullExplanation:
          'Pengusaha wajib membayarkan THR Keagamaan kepada pekerja yang telah memiliki masa kerja minimal 1 bulan terus-menerus. Masa kerja 12 bulan atau lebih mendapat 1 bulan upah. Masa kerja kurang dari 12 bulan dihitung prorata: (masa kerja / 12) x 1 bulan upah.',
      legalBasis: 'Permenaker No. 6 Tahun 2016 jo. PP No. 36 Tahun 2021',
      penaltyOrRight: 'Denda keterlambatan 5% dari total THR yang harus dibayar serta sanksi administratif',
      keyDos: [
        'Ketahui tanggal H-7 Idul Fitri / Hari Raya Keagamaan',
        'Laporkan ke Posko THR Kemnaker jika perusahaan mencicil atau telat membayar THR',
      ],
      keyDonts: [
        'Menerima pembayaran THR dalam bentuk parsel atau barang pengganti uang',
        'Menerima cicilan THR tanpa kesepakatan tertulis resmi yang disahkan Disnaker',
      ],
      keywords: ['thr', 'tunjangan hari raya', 'h-7', 'idul fitri', 'upah prorata', 'posko thr'],
    ),
    RuleItem(
      id: 'labor-04',
      title: 'Kompensasi Pengakhiran Hubungan Kerja (PHK & Pesangon)',
      category: RuleCategory.labor,
      summary: 'Perusahaan wajib membayar Uang Pesangon, UPMK, dan UPH sesuai formula masa kerja dan alasan pemutusan hubungan kerja.',
      fullExplanation:
          'Dalam hal terjadi PHK, pengusaha wajib membayar kompensasi berupa Uang Pesangon (maksimal 9 bulan upah), Uang Penghargaan Masa Kerja / UPMK (maksimal 10 bulan upah), dan Uang Penggantian Hak (UPH cuti/ongkos pulang). Faktor pengali disesuaikan dengan alasan PHK.',
      legalBasis: 'PP No. 35 Tahun 2021 Pasal 40 s.d. Pasal 59 jo. UU Cipta Kerja',
      penaltyOrRight: 'Hak kompensasi wajib dibayar penuh; sanksi perdata PHI & pengawasan Disnaker',
      keyDos: [
        'Mintakan bukti tertulis alasan resmi PHK dari manajemen',
        'Gunakan kalkulator pesangon resmi untuk memverifikasi nominal sebelum tanda tangan',
      ],
      keyDonts: [
        'Menandatangani surat pengunduran diri palsu / paksaan yang menghilangkan hak pesangon',
        'Menerima nominal pesangon di bawah batas minimum regulasi PP 35/2021',
      ],
      keywords: ['phk', 'pesangon', 'upmk', 'uph', 'kompensasi phk', 'bipartit', 'disnaker'],
    ),
    RuleItem(
      id: 'labor-05',
      title: 'Kompensasi Pekerja Kontrak (PKWT)',
      category: RuleCategory.labor,
      summary: 'Pekerja kontrak (PKWT) berhak mendapat uang kompensasi pada saat berakhirnya jangka waktu kontrak.',
      fullExplanation:
          'Pengusaha wajib memberikan uang kompensasi kepada pekerja PKWT yang telah memiliki masa kerja minimal 1 bulan terus menerus saat kontrak berakhir atau diperpanjang. Formula: (Masa Kerja / 12) x 1 bulan upah.',
      legalBasis: 'PP No. 35 Tahun 2021 Pasal 15, 16, & 17',
      penaltyOrRight: 'Hak kompensasi wajib diserahkan paling lambat pada hari terakhir masa kontrak',
      keyDos: [
        'Pastikan perjanjian kerja memuat tanggal mulai dan berakhirnya kontrak secara tegas',
        'Hitung hak kompensasi PKWT setiap kali periode perpanjangan kontrak selesai',
      ],
      keyDonts: [
        'Menganggap pekerja kontrak tidak memiliki hak pesangon/kompensasi sama sekali',
        'Memperkerjakan PKWT untuk pekerjaan yang bersifat tetap terus menerus tanpa batas',
      ],
      keywords: ['pkwt', 'pekerja kontrak', 'uang kompensasi', 'perpanjangan kontrak'],
    ),
    RuleItem(
      id: 'labor-06',
      title: 'Kewajiban Kepesertaan BPJS Ketenagakerjaan',
      category: RuleCategory.labor,
      summary: 'Perusahaan wajib mendaftarkan seluruh pekerja ke program BPJS Ketenagakerjaan (JKK, JKM, JHT, JP).',
      fullExplanation:
          'Setiap pemberi kerja wajib mendaftarkan pekerjanya dalam program Jaminan Kecelakaan Kerja (JKK), Jaminan Kematian (JKM), Jaminan Hari Tua (JHT), dan Jaminan Pensiun (JP) serta menyetorkan iurannya secara tertib.',
      legalBasis: 'UU No. 24 Tahun 2011 Pasal 15 jo. PP No. 44/2015',
      penaltyOrRight: 'Sanksi tidak mendapat pelayanan publik tertentu bagi pengusaha dan denda keterlambatan',
      keyDos: [
        'Cek saldo JHT dan status kepesertaan aktif melalui aplikasi JMO secara berkala',
        'Laporkan ke Disnaker jika potongan upah BPJS tidak disetorkan oleh perusahaan',
      ],
      keyDonts: [
        'Menerima pemotongan upah sepihak tanpa adanya kartu peserta BPJS resmi',
        'Bekerja di lingkungan bahaya tanpa proteksi Jaminan Kecelakaan Kerja (JKK)',
      ],
      keywords: ['bpjs', 'bpjs ketenagakerjaan', 'jht', 'jkk', 'jkm', 'jmo', 'jaminan sosial'],
    ),

    // --- PRIVASI & UU ITE ---
    RuleItem(
      id: 'privacy-01',
      title: 'Pencemaran Nama Baik & Delik Aduan Siber',
      category: RuleCategory.privacy,
      summary: 'Penyerangan kehormatan di media elektronik adalah delik aduan absolut; kritik publik bukan pidana.',
      fullExplanation:
          'UU ITE Revisi Kedua No. 1/2024 menegaskan bahwa tindak pidana pencemaran nama baik adalah delik aduan absolut yang hanya bisa dilaporkan oleh korban perseorangan langsung. Ditegaskan pula perbuatan tidak dipidana jika dilakukan demi kepentingan umum atau terpaksa membela diri.',
      legalBasis: 'UU No. 1 Tahun 2024 Pasal 27A jo. Pasal 45 ayat (4)',
      penaltyOrRight: 'Pidana penjara maksimal 2 tahun dan/atau denda maksimal Rp 400.000.000',
      keyDos: [
        'Sampaikan kritik dengan basis fakta, data, dan rujukan yang dapat dibuktikan',
        'Gunakan bahasa etis tanpa melontarkan umpatan atau kata penghinaan pribadi',
      ],
      keyDonts: [
        'Menyebarkan tuduhan asusila atau fitnah tanpa bukti di media sosial terbuka',
        'Menggunakan nama orang lain untuk membuat akun gosip palsu',
      ],
      keywords: ['uu ite', 'pencemaran nama baik', 'fitnah', 'delik aduan', 'kritik publik'],
    ),
    RuleItem(
      id: 'privacy-02',
      title: 'Hak Subjek Data Pribadi (UU PDP)',
      category: RuleCategory.privacy,
      summary: 'Masyarakat berhak mengakses, memperbaiki, menghapus, dan menarik persetujuan pemrosesan data pribadi.',
      fullExplanation:
          'UU Perlindungan Data Pribadi (UU PDP) menjamin hak subjek data untuk meminta salinan data, mengubah ketidakakuratan, membatasi pemrosesan, dan menuntut ganti rugi atas pelanggaran kebocoran data pribadi oleh korporasi atau badan publik.',
      legalBasis: 'UU No. 27 Tahun 2022 (UU PDP) Pasal 5 s.d. Pasal 15',
      penaltyOrRight: 'Denda administratif hingga 2% dari total pendapatan tahunan korporasi pelanggar',
      keyDos: [
        'Ajukan permohonan tertulis penghapusan data akun saat berhenti memakai layanan digital',
        'Periksa izin akses kontak, mikrofon, dan lokasi pada aplikasi smartphone',
      ],
      keyDonts: [
        'Membagikan foto KTP, Kartu Keluarga, atau nomor rekening di grup pesan publik',
        'Menyetujui syarat & ketentuan aplikasi yang meminta akses data tidak relevan',
      ],
      keywords: ['uu pdp', 'data pribadi', 'ktp', 'kebocoran data', 'privasi digital', 'penghapusan akun'],
    ),
    RuleItem(
      id: 'privacy-03',
      title: 'Kewajiban Notifikasi Kebocoran Data (Aturan 72 Jam)',
      category: RuleCategory.privacy,
      summary: 'Pengendali data wajib menyampaikan pemberitahuan tertulis kebocoran data maksimal 3x24 jam (72 jam).',
      fullExplanation:
          'Dalam hal terjadi kegagalan perlindungan data pribadi (data breach), Pengendali Data Pribadi wajib menyampaikan pemberitahuan tertulis paling lambat 72 jam kepada Subjek Data Pribadi dan lembaga pengawas resmi.',
      legalBasis: 'UU No. 27 Tahun 2022 Pasal 46 ayat (1) & (2)',
      penaltyOrRight: 'Sanksi peringatan tertulis, pembekuan kegiatan bisnis, hingga denda administratif raksasa',
      keyDos: [
        'Segera ganti kata sandi dan aktifkan 2-Factor Authentication (2FA) jika ada pemberitahuan kebocoran',
        'Pantau mutasi rekening bank dan peringatan login akun yang mencurigakan',
      ],
      keyDonts: [
        'Menyembunyikan insiden peretasan sistem dari publik dan otoritas pengawas',
        'Mengabaikan email notifikasi keamanan dari platform terpercaya',
      ],
      keywords: ['72 jam', 'kebocoran data', 'data breach', 'notifikasi', 'hacker', 'komdigi'],
    ),
    RuleItem(
      id: 'privacy-04',
      title: 'Larangan Penyebaran Data Pribadi Tanpa Hak (Doxxing)',
      category: RuleCategory.privacy,
      summary: 'Dilarang keras menyebarkan data pribadi orang lain untuk mengintimidasi atau merugikan korban.',
      fullExplanation:
          'Tindakan menyebarkan KTP, nomor telepon, alamat rumah, atau data finansial orang lain di internet dengan maksud mencelakakan atau mengintimidasi korban (doxxing) diancam sanksi pidana berat.',
      legalBasis: 'UU No. 27 Tahun 2022 Pasal 65 ayat (2) jo. Pasal 67 ayat (2)',
      penaltyOrRight: 'Pidana penjara paling lama 5 tahun dan/atau pidana denda paling banyak Rp 5.000.000.000',
      keyDos: [
        'Sensor (blur) nama lengkap, NIK, dan nomor telepon saat membagikan bukti transaksi',
        'Laporkan konten doxxing ke tim moderasi platform dan patroli siber kepolisian',
      ],
      keyDonts: [
        'Memposting KTP lawan transaksi di medsos dengan dalih penagihan utang / viralitas',
        'Membuat database data pribadi warga tanpa persetujuan eksplisit pemilik data',
      ],
      keywords: ['doxxing', 'sebar ktp', 'ancaman', 'intimidasi', 'pidana data'],
    ),
    RuleItem(
      id: 'privacy-05',
      title: 'Jerat Pidana Penipuan Transaksi Online & Phishing',
      category: RuleCategory.privacy,
      summary: 'Menyebarkan informasi bohong dalam transaksi elektronik yang merugikan konsumen diancam pidana.',
      fullExplanation:
          'Setiap orang yang dengan sengaja menyebarkan berita bohong dan menyesatkan dalam transaksi elektronik (toko online palsu, link phishing file APK, investasi bodong) dijerat pasal tindak pidana siber.',
      legalBasis: 'UU No. 1 Tahun 2024 Pasal 28 ayat (1) jo. Pasal 45A ayat (1)',
      penaltyOrRight: 'Pidana penjara paling lama 6 tahun dan/atau denda paling banyak Rp 1.000.000.000',
      keyDos: [
        'Gunakan fitur rekening bersama (rekber) resmi atau marketplace terpercaya',
        'Cek kredibilitas nomor rekening tujuan di portal cekrekening.id resmi pemerintah',
      ],
      keyDonts: [
        'Mengunduh atau mengklik file ekstensi .APK misterius dari WhatsApp',
        'Mentransfer uang langsung tanpa jaminan escrow ke penjual anonim',
      ],
      keywords: ['phishing', 'penipuan online', 'file apk', 'cek rekening', 'toko palsu'],
    ),

    // --- PERLINDUNGAN KONSUMEN (CONSUMER) ---
    RuleItem(
      id: 'consumer-01',
      title: 'Hak Pengembalian & Kompensasi Barang Cacat / Rusak',
      category: RuleCategory.consumer,
      summary: 'Pelaku usaha wajib mengganti rugi atau menukar barang cacat/rusak yang tidak sesuai perjanjian.',
      fullExplanation:
          'Pelaku usaha bertanggung jawab memberikan ganti rugi atas kerusakan, pencemaran, dan/atau kerugian konsumen akibat mengonsumsi barang yang dihasilkan atau diperdagangkan. Ganti rugi dapat berupa pengembalian uang atau penggantian barang sejenis.',
      legalBasis: 'UU No. 8 Tahun 1999 tentang Perlindungan Konsumen Pasal 19',
      penaltyOrRight: 'Ganti rugi wajib dilaksanakan dalam tenggang waktu 7 hari setelah tanggal transaksi',
      keyDos: [
        'Rekam video pembukaan paket (unboxing) dari kondisi segel utuh tanpa jeda',
        'Simpan struk pembelian fisik atau invoice digital resmi',
      ],
      keyDonts: [
        'Menerima klausula sepihak "Barang yang sudah dibeli tidak dapat dikembalikan"',
        'Membuang kemasan kardus atau kartu garansi sebelum barang dipastikan berfungsi baik',
      ],
      keywords: ['konsumen', 'barang rusak', 'garansi', 'unboxing', 'ganti rugi', 'bpsk'],
    ),
    RuleItem(
      id: 'consumer-02',
      title: 'Larangan Klausula Baku yang Merugikan Konsumen',
      category: RuleCategory.consumer,
      summary: 'Klausula sepihak yang membebaskan pelaku usaha dari tanggung jawab dinyatakan batal demi hukum.',
      fullExplanation:
          'Pelaku usaha dilarang mencantumkan klausula baku yang menyatakan pengalihan tanggung jawab, menyatakan tunduk pada peraturan baru sepihak, atau menyatakan konsumen memberi hak mengurangi kegunaan barang.',
      legalBasis: 'UU No. 8 Tahun 1999 Pasal 18 ayat (1) & (3)',
      penaltyOrRight: 'Klausula batal demi hukum; pidana penjara paling lama 5 tahun atau denda Rp 2.000.000.000',
      keyDos: [
        'Ketahui bahwa klausula "kerusakan dalam pengiriman bukan tanggung jawab penjual" tidak sah di mata hukum',
        'Tuntut hak penggantian jika penjual mengabaikan garansi cacat tersembunyi',
      ],
      keyDonts: [
        'Takut mengajukan sengketa konsumen ke BPSK karena klaim tulisan sepihak struk toko',
        'Menerima denda pembatalan sepihak yang tidak masuk akal dari penyedia jasa',
      ],
      keywords: ['klausula baku', 'batal demi hukum', 'struk', 'tanggung jawab penjual'],
    ),
    RuleItem(
      id: 'consumer-03',
      title: 'Kewajiban Kejelasan Harga & Spesifikasi Barang',
      category: RuleCategory.consumer,
      summary: 'Pelaku usaha dilarang menjual barang dengan harga di kasir yang berbeda dengan label rak.',
      fullExplanation:
          'Konsumen berhak atas informasi yang benar, jelas, dan jujur mengenai kondisi dan jaminan barang/jasa. Jika terdapat perbedaan harga antara rak pajang dan mesin kasir kasir, harga yang berlaku adalah harga terendah yang tertera di rak.',
      legalBasis: 'UU No. 8 Tahun 1999 Pasal 4 & Permendag No. 35/2013',
      penaltyOrRight: 'Konsumen berhak membayar sesuai harga rak termurah yang terpasang',
      keyDos: [
        'Foto label harga di rak pajang jika mencurigai ada perbedaan harga',
        'Minta koreksi langsung ke kasir sebelum struk pembayaran dicetak',
      ],
      keyDonts: [
        'Membiarkan kasir membebankan selisih harga sepihak tanpa penjelasan',
        'Membeli produk tanpa label tanggal kadaluarsa atau komposisi bahasa Indonesia',
      ],
      keywords: ['beda harga kasir', 'harga rak', 'label harga', 'hak konsumen', 'kejujuran'],
    ),
    RuleItem(
      id: 'consumer-04',
      title: 'Larangan Menjual Makanan / Obat Kadaluarsa',
      category: RuleCategory.consumer,
      summary: 'Dilarang memperdagangkan makanan, minuman, dan obat-obatan yang telah melampaui tanggal kadaluarsa.',
      fullExplanation:
          'Pelaku usaha dilarang memproduksi dan/atau memperdagangkan barang yang tidak memenuhi atau tidak sesuai dengan standar yang dipersyaratkan dan ketentuan peraturan perundang-undangan atau telah kadaluarsa.',
      legalBasis: 'UU No. 8 Tahun 1999 Pasal 8 ayat (1) huruf g jo. UU Pangan No. 18/2012',
      penaltyOrRight: 'Pidana penjara paling lama 5 tahun atau denda paling banyak Rp 2.000.000.000',
      keyDos: [
        'Periksa cap tanggal Best Before / Expired Date dan izin BPOM sebelum membeli',
        'Laporkan ke BPOM atau Disperindag jika menemukan toko yang menjual produk kadaluarsa secara sengaja',
      ],
      keyDonts: [
        'Mengonsumsi produk makanan kaleng dengan kemasan gembung atau rusak segelnya',
        'Menerima barang expired meskipun diberi diskon cuci gudang sangat murah',
      ],
      keywords: ['kadaluarsa', 'expired date', 'bpom', 'makanan basi', 'obat berbahaya'],
    ),

    // --- KESELAMATAN (K3) ---
    RuleItem(
      id: 'safety-01',
      title: 'Kewajiban Penggunaan Alat Pelindung Diri (APD)',
      category: RuleCategory.safety,
      summary: 'Pengurus wajib menyediakan APD cuma-cuma dan tenaga kerja wajib menggunakannya di area bahaya.',
      fullExplanation:
          'Pengurus tempat kerja diwajibkan menyediakan alat-alat perlindungan diri secara cuma-cuma bagi semua tenaga kerja dan orang lain yang memasuki tempat kerja sesuai dengan bahaya yang ada.',
      legalBasis: 'UU No. 1 Tahun 1970 Pasal 14 huruf c & Permenakertrans No. 8/2010',
      penaltyOrRight: 'Hak pekerja mendapatkan APD standar; sanksi administratif dan pidana kurungan bagi pengurus',
      keyDos: [
        'Pakai helm proyek, sepatu safety, kacamata pelindung, dan rompi reflektor di zona kerja',
        'Periksa kelayakan fungsi APD sebelum mulai bekerja dan minta penggantian jika rusak',
      ],
      keyDonts: [
        'Memotong atau memodifikasi APD standar demi kenyamanan sesaat',
        'Membebankan biaya pembelian APD kepada upah pekerja',
      ],
      keywords: ['apd', 'k3', 'helm proyek', 'sepatu safety', 'keselamatan kerja', 'uu 1 1970'],
    ),
    RuleItem(
      id: 'safety-02',
      title: 'Standar Jalur Evakuasi Darurat & APAR Gedung',
      category: RuleCategory.safety,
      summary: 'Gedung dan tempat kerja wajib memiliki sarana evakuasi, pintu darurat bebas rintangan, dan APAR siap pakai.',
      fullExplanation:
          'Setiap bangunan tempat kerja wajib dilengkapi dengan sarana proteksi kebakaran (APAR), penunjuk arah evakuasi darurat bercahaya (emergency exit), dan pintu darurat yang membuka ke arah luar tanpa terkunci saat jam kerja.',
      legalBasis: 'Permenaker No. 04/MEN/1980 & Permenaker No. 186/1999',
      penaltyOrRight: 'Pemeriksaan berkala K3 oleh pengawas ketenagakerjaan dan penutupan area kerja yang berisiko fatal',
      keyDos: [
        'Ketahui lokasi APAR terdekat dan pelajari cara pengoperasian PASS (Pull, Aim, Squeeze, Sweep)',
        'Pastikan tangga darurat selalu bersih dan bebas dari tumpukan barang logistik',
      ],
      keyDonts: [
        'Mengunci pintu keluar darurat atau menghalanginya dengan meja/lemari',
        'Menggunakan lift saat terjadi gempa bumi atau kebakaran gedung',
      ],
      keywords: ['apar', 'pintu darurat', 'jalur evakuasi', 'kebakaran', 'sop bencana'],
    ),
    RuleItem(
      id: 'safety-03',
      title: 'Hak Penolakan Pekerjaan yang Berbahaya Ekstrem',
      category: RuleCategory.safety,
      summary: 'Pekerja berhak menyatakan keberatan melakukan kerja di mana syarat K3 tidak dipenuhi atau bahaya fatal mengancam.',
      fullExplanation:
          'Tenaga kerja berhak menyatakan keberatan kerja pada pekerjaan di mana syarat keselamatan dan kesehatan kerja serta alat perlindungan diri yang diwajibkan diragukan olehnya kecuali dalam hal-hal khusus yang dapat dipertanggungjawabkan.',
      legalBasis: 'UU No. 1 Tahun 1970 Pasal 12 huruf d',
      penaltyOrRight: 'Pekerja dilindungi dari sanksi pemecatan sepihak jika menolak bekerja tanpa APD layak',
      keyDos: [
        'Laporkan ke petugas K3 / P2K3 sebelum menjalankan tugas berisiko tinggi',
        'Pastikan ada izin kerja khusus (Work Permit) untuk ketinggian, ruang terbatas, atau tegangan tinggi',
      ],
      keyDonts: [
        'Memaksakan diri bekerja di ketinggian tanpa safety harness bersertifikasi',
        'Bekerja dengan mesin berputar tanpa pelindung pengaman (machine guarding)',
      ],
      keywords: ['tolak kerja', 'bahaya fatal', 'ketinggian', 'work permit', 'p2k3'],
    ),
    RuleItem(
      id: 'safety-04',
      title: 'Santunan Kecelakaan Kerja & Hak Pengobatan Penuh',
      category: RuleCategory.safety,
      summary: 'Korban kecelakaan kerja berhak atas penggantian biaya medis tanpa batas plafon sesuai indikasi medis.',
      fullExplanation:
          'Melalui program JKK BPJS Ketenagakerjaan, pekerja yang mengalami kecelakaan saat berangkat, di lokasi kerja, atau dalam perjalanan dinas berhak atas biaya perawatan medis sampai sembuh tanpa batasan plafon rupiah.',
      legalBasis: 'PP No. 82 Tahun 2019 tentang Perubahan atas PP No. 44 Tahun 2015',
      penaltyOrRight: 'Santunan STMB (Sementara Tidak Mampu Bekerja) 100% upah selama 6 bulan pertama',
      keyDos: [
        'Segera bawa korban ke RS Pusat Layanan Kecelakaan Kerja (PLKK) mitra BPJS',
        'Laporkan kecelakaan kerja ke Disnaker dan BPJS Ketenagakerjaan maksimal 2x24 jam',
      ],
      keyDonts: [
        'Menyembunyikan insiden kecelakaan kerja dari pencatatan buku audit K3',
        'Memotong upah pekerja yang sedang dalam masa pemulihan medis akibat kecelakaan dinas',
      ],
      keywords: ['santunan', 'jkk', 'plkk', 'kecelakaan dinas', 'sembuh tanpa batas'],
    ),

    // --- ETIKA PUBLIK & KETERTIBAN (ETHICS) ---
    RuleItem(
      id: 'ethics-01',
      title: 'Gangguan Kebisingan Lingkungan & Jam Malam',
      category: RuleCategory.ethics,
      summary: 'Membuat kebisingan berlebihan yang mengganggu ketentraman tetangga pada malam hari diancam pidana denda.',
      fullExplanation:
          'KUHP Baru (UU No. 1/2023) dan Perda Ketertiban Umum melarang perbuatan membuat kegaduhan atau kebisingan tetangga pada malam hari (pukul 22.00 - 06.00) yang merusak kenyamanan istirahat warga sekitar.',
      legalBasis: 'UU No. 1 Tahun 2023 Pasal 265 KUHP & Perda Ketertiban Umum',
      penaltyOrRight: 'Pidana denda kategori II (maksimal Rp 10.000.000)',
      keyDos: [
        'Turunkan volume suara audio, musik, atau mesin perbaikan rumah setelah pukul 21.00 WIB',
        'Musyawarahkan rencana pesta atau hajatan terlebih dahulu dengan RT dan tetangga berdekatan',
      ],
      keyDonts: [
        'Memutar musik menggelegar (sound horeg) di jalan sempit permukiman tengah malam',
        'Menyalakan petasan berdaya ledak tinggi di sekitar pemukiman warga dan rumah sakit',
      ],
      keywords: ['kebisingan', 'suara keras', 'sound horeg', 'jam malam', 'kuhp baru', 'tetangga'],
    ),
    RuleItem(
      id: 'ethics-02',
      title: 'Parkir Liar di Depan Pintu Rumah Orang Lain',
      category: RuleCategory.ethics,
      summary: 'Dilarang memarkir kendaraan yang menghalangi akses keluar-masuk pekarangan rumah orang lain.',
      fullExplanation:
          'Setiap pemilik kendaraan bermotor wajib memiliki atau menguasai garasi yang memadai dan dilarang memarkir kendaraan di ruang milik jalan yang mengganggu fungsi jalan atau akses pekarangan warga.',
      legalBasis: 'Perda DKI No. 5/2014 Pasal 140 jo. KUHPerdata Pasal 1365 (Perbuatan Melawan Hukum)',
      penaltyOrRight: 'Sanksi penderekan retribusi dinas perhubungan dan gugatan perdata ganti rugi',
      keyDos: [
        'Pastikan kendaraan diparkir di dalam pagar rumah sendiri atau tempat penitipan resmi',
        'Beri nomor telepon kontak di dashboard jika terpaksa berhenti darurat sesaat',
      ],
      keyDonts: [
        'Memarkir mobil di depan pintu pagar tetangga hingga tetangga tidak bisa mengeluarkan kendaraan',
        'Memasang patok beton atau portal pribadi di jalan umum tanpa izin RW',
      ],
      keywords: ['parkir liar', 'garasi', 'pintu tetangga', 'derek dishub', 'jalan umum'],
    ),
    RuleItem(
      id: 'ethics-03',
      title: 'Pembuangan Sampah Sembarangan & Pembakaran Liar',
      category: RuleCategory.ethics,
      summary: 'Dilarang membuang sampah ke sungai/saluran air atau membakar sampah yang mengasapi tetangga.',
      fullExplanation:
          'Setiap orang dilarang membuang sampah sembarangan di jalan, fasilitas umum, kali, dan sungai, serta dilarang membakar sampah yang tidak sesuai persyaratan teknis pengelolaan sampah.',
      legalBasis: 'UU No. 18 Tahun 2008 tentang Pengelolaan Sampah jo. Perda Kebersihan',
      penaltyOrRight: 'Sanksi denda administrasi hingga Rp 500.000 - Rp 5.000.000 atau kurungan pidana',
      keyDos: [
        'Pilah sampah organik, anorganik, dan limbah B3 sesuai jadwal petugas kebersihan',
        'Komposkan sisa daun kering daripada membakarnya di pekarangan padat penduduk',
      ],
      keyDonts: [
        'Melempar kantong plastik sampah dari jendela mobil ke jalan raya',
        'Membakar tumpukan sampah plastik yang menghasilkan asap dioksin beracun',
      ],
      keywords: ['sampah', 'bakar sampah', 'buang sampah', 'sungai', 'denda perda', 'kebersihan'],
    ),
    RuleItem(
      id: 'ethics-04',
      title: 'Kewajiban Pengawasan Hewan Peliharaan di Ruang Publik',
      category: RuleCategory.ethics,
      summary: 'Pemilik wajib mengawasi hewan peliharaan agar tidak menyerang, menggigit, atau mengotori ruang publik.',
      fullExplanation:
          'Setiap orang yang memelihara binatang buas atau berbahaya wajib menjaga agar tidak membahayakan keselamatan orang lain. Pemilik bertanggung jawab penuh atas segala kerugian fisik dan materi akibat gigitan hewannya.',
      legalBasis: 'UU No. 1 Tahun 2023 Pasal 339 KUHP & KUHPerdata Pasal 1368',
      penaltyOrRight: 'Pidana penjara maksimal 6 bulan atau denda kategori II serta ganti rugi biaya medis korban',
      keyDos: [
        'Gunakan tali kekang (leash) dan penutup mulut (muzzle) saat membawa anjing jalan di taman publik',
        'Bawa kantong plastik untuk membersihkan kotoran hewan peliharaan Anda sendiri',
      ],
      keyDonts: [
        'Membiarkan hewan peliharaan berkeliaran tanpa pengawasan di jalan depan rumah warga',
        'Menolak menanggung biaya suntik rabies / perawatan medis saat hewan peliharaan melukai orang lain',
      ],
      keywords: ['hewan peliharaan', 'anjing', 'gigitan', 'tali kekang', 'kuhp 339', 'rabies'],
    ),
  ];

  // --- SOP DARURAT & PANDUAN SITUASI ---
  static const List<SopGuide> sopGuides = [
    SopGuide(
      id: 'sop-razia-tilang',
      title: 'SOP Menghadapi Razia & Tilang Polisi',
      category: RuleCategory.traffic,
      targetScenario: 'Dihentikan oleh petugas kepolisian lalu lintas dalam razia atau patroli jalan raya.',
      legalBasis: 'PP No. 80 Tahun 2012 tentang Tata Cara Pemeriksaan Kendaraan Bermotor jo. UU 22/2009',
      rightsSummary: [
        'Berhak melihat Surat Perintah Tugas resmi razia dari petugas',
        'Razia wajib dilengkapi papan tanda pemeriksaan sekurang-kurangnya 50 meter sebelumnya',
        'Petugas wajib berseragam lengkap, memakai atribut nama, dan lencana dinas',
        'Berhak memilih Slip Biru (mengakui pelanggaran & bayar via transfer bank) bukan Slip Merah sidang kecuali jika membantah pasal',
        'Dilarang melakukan transaksi damai tunai di tempat (pungli / suap)',
      ],
      emergencyContacts: [
        EmergencyContact(name: 'Call Center Polri', contactNumber: '110', note: 'Laporan darurat & kepolisian 24 jam'),
        EmergencyContact(name: 'Propam Polri (Lapor Pungli)', contactNumber: '0813-8663-3046', note: 'WhatsApp Pengaduan Pelanggaran Oknum Propam'),
      ],
      steps: [
        SopStep(
          stepNumber: 1,
          title: 'Tepikan Kendaraan dengan Tenang & Aman',
          detail: 'Nyalakan lampu sein kiri, kurangi kecepatan perlahan, dan berhenti di bahu jalan yang aman tanpa menghalangi arus lalu lintas. Matikan mesin dan buka kaca jendela secukupnya.',
          practicalTip: 'Tetap berada di dalam mobil atau di atas motor sampai petugas mendekat dengan sopan.',
        ),
        SopStep(
          stepNumber: 2,
          title: 'Ucapkan Salam & Perhatikan Identitas Petugas',
          detail: 'Petugas profesional wajib memberi hormat dan menyapa dengan sopan. Perhatikan badge nama dan korps di seragam dinas.',
          warning: 'Jika petugas tidak berseragam atau tidak memiliki surat perintah, Anda berhak menanyakan legalitas pemeriksaan sesuai Pasal 15 PP 80/2012.',
        ),
        SopStep(
          stepNumber: 3,
          title: 'Tanyakan Alasan Penghentian & Pasal Pelanggaran',
          detail: 'Tanyakan dengan tenang: "Mohon maaf Pak, apa alasan penghentian dan pasal apa yang diduga dilanggar?". Petugas wajib menjelaskan dugaan pelanggaran secara spesifik.',
          practicalTip: 'Jangan memotong ucapan petugas, dengarkan pasal yang disebutkan.',
        ),
        SopStep(
          stepNumber: 4,
          title: 'Tunjukkan Dokumen SIM & STNK Sah',
          detail: 'Tunjukkan SIM yang masih berlaku dan STNK kendaraan. Petugas berhak memeriksa fisik dokumen untuk memastikan kecocokan nomor plat dan masa pajak.',
          warning: 'Jangan menyelipkan uang tunai dalam dokumen!',
        ),
        SopStep(
          stepNumber: 5,
          title: 'Minta Slip Biru & Catat Kode Bayar BRIVA',
          detail: 'Jika memang melakukan pelanggaran, mintalah Slip Biru untuk membayar denda resmi melalui transfer bank/ATM/m-banking. Anda tidak perlu hadir sidang pengadilan dan SIM/STNK disita sementara sebagai tanda bukti hingga denda lunas.',
          practicalTip: 'Setelah bayar via m-banking, struk bukti pembayaran dibawa ke kantor Satlantas untuk mengambil dokumen Anda.',
        ),
      ],
    ),
    SopGuide(
      id: 'sop-phk-sepihak',
      title: 'SOP Menghadapi PHK Sepihak Tanpa Pesangon',
      category: RuleCategory.labor,
      targetScenario: 'Diberhentikan kerja mendadak atau dipaksa mengundurkan diri tanpa hak pesangon resmi.',
      legalBasis: 'UU No. 2 Tahun 2004 tentang PPHI jo. PP No. 35 Tahun 2021',
      rightsSummary: [
        'Perusahaan wajib menyampaikan surat pemberitahuan PHK minimal 14 hari kerja sebelumnya',
        'Pekerja berhak menolak alasan PHK secara tertulis dalam tempo 7 hari kerja',
        'Dilarang dipaksa menandatangani surat resign palsu yang menghanguskan pesangon',
        'Berhak menuntut perundingan Bipartit resmi yang dituangkan dalam Risalah Bipartit',
        'Berhak mengajukan mediasi Tripartit ke Kantor Dinas Tenaga Kerja (Disnaker)',
      ],
      emergencyContacts: [
        EmergencyContact(name: 'Halo Kemnaker', contactNumber: '1500396', note: 'Layanan Pengaduan Ketenagakerjaan Resmi'),
        EmergencyContact(name: 'Posko Pengaduan Disnaker', contactNumber: '0811-952-115', note: 'Konsultasi Perselisihan Hubungan Industrial'),
      ],
      steps: [
        SopStep(
          stepNumber: 1,
          title: 'JANGAN Pernah Tanda Tangani Surat Resign / Form Kosong',
          detail: 'Manajemen sering membujuk pekerja menandatangani surat pengunduran diri dengan janji manis. Begitu Anda menandatangani resign, hak pesangon dan UPMK Anda gugur secara hukum.',
          warning: 'Katakan tegas: "Saya membutuhkan waktu untuk membaca dan mempelajari dokumen ini bersama penasihat hukum / keluarga."',
        ),
        SopStep(
          stepNumber: 2,
          title: 'Kumpulkan Seluruh Bukti Hubungan Kerja & Finansial',
          detail: 'Amankan salinan Perjanjian Kerja (PKWT/PKWTT), slip gaji 3-6 bulan terakhir, mutasi rekening bank penerima gaji, surat perintah kerja, email/chat penugasan, dan ID card.',
          practicalTip: 'Simpan backup bukti-bukti ini di Google Drive atau penyimpanan pribadi di luar perangkat kantor.',
        ),
        SopStep(
          stepNumber: 3,
          title: 'Kirim Surat Penolakan PHK Resmi (Maksimal 7 Hari Kerja)',
          detail: 'Buat surat tanggapan tertulis yang menyatakan menolak PHK sepihak dan meminta dibukanya forum perundingan Bipartit sesuai amanat UU No. 2 Tahun 2004.',
          practicalTip: 'Kirim surat via email resmi dan cetak fisik dengan tanda terima bermaterai.',
        ),
        SopStep(
          stepNumber: 4,
          title: 'Laksanakan Perundingan Bipartit & Buat Risalah',
          detail: 'Lakukan perundingan antara pekerja/serikat pekerja dengan pihak manajemen maksimal 30 hari kerja. Catat seluruh tawaran dan keberatan dalam Risalah Perundingan Bipartit.',
          warning: 'Jika musyawarah gagal mencapai mufakat, mintakan tanda tangan Risalah Bipartit Gagal dari kedua belah pihak.',
        ),
        SopStep(
          stepNumber: 5,
          title: 'Daftarkan Mediasi Tripartit ke Suku Dinas Tenaga Kerja',
          detail: 'Bawa berkas risalah Bipartit gagal ke kantor Disnaker setempat untuk permohonan Mediasi Hubungan Industrial. Mediator Disnaker akan memanggil kedua belah pihak dan mengeluarkan Surat Anjuran tertulis yang berkekuatan hukum.',
          practicalTip: 'Layanan mediasi di Disnaker bersifat GRATIS tanpa dipungut biaya apapun.',
        ),
      ],
    ),
    SopGuide(
      id: 'sop-sengketa-konsumen',
      title: 'SOP Komplain Barang Cacat & Penipuan Belanja Online',
      category: RuleCategory.consumer,
      targetScenario: 'Barang yang dibeli rusak, palsu, tidak sesuai deskripsi, atau penjual kabur menolak tanggung jawab.',
      legalBasis: 'UU No. 8 Tahun 1999 tentang Perlindungan Konsumen jo. PP No. 80 Tahun 2019 (PMSE)',
      rightsSummary: [
        'Konsumen berhak atas pengembalian dana penuh atau penggantian produk baru sejenis',
        'Klausula sepihak toko "barang tidak dapat dikembalikan" batal demi hukum',
        'Penjual wajib menanggung biaya ongkos kirim retur untuk barang cacat bawaan',
        'Bila transaksi di marketplace, ajukan Pusat Resolusi SEBELUM menekan tombol "Pesanan Selesai"',
        'Dapat mengajukan penyelesaian sengketa gratis melalui Badan Penyelesaian Sengketa Konsumen (BPSK)',
      ],
      emergencyContacts: [
        EmergencyContact(name: 'Hotline Konsumen Kemendag', contactNumber: '0853-1111-1010', note: 'WhatsApp Pengaduan Konsumen Ditjen PKTN'),
        EmergencyContact(name: 'BPKN RI (Layanan Konsumen)', contactNumber: '153', note: 'Badan Perlindungan Konsumen Nasional'),
      ],
      steps: [
        SopStep(
          stepNumber: 1,
          title: 'Simpan Bukti Pembelian & Video Unboxing Tanpa Jeda',
          detail: 'Dokumentasikan nomor resi pengiriman, invoice pembelian, foto label kemasan luar, dan video proses membuka paket dari kondisi lakban masih rapat.',
          practicalTip: 'Pastikan tanggal dan nomor resi terlihat jelas di dalam rekaman video.',
        ),
        SopStep(
          stepNumber: 2,
          title: 'Tahan Status Pesanan (JANGAN Klik Pesanan Diterima / Selesai)',
          detail: 'Di marketplace (Shopee, Tokopedia, TikTok Shop, dll.), jika Anda menekan tombol pesanan selesai, dana otomatis dilepas ke rekening penjual. Segera klik "Ajukan Pengembalian / Komplain".',
          warning: 'Dana di escrow marketplace akan dibekukan selama proses mediasi berlangsung.',
        ),
        SopStep(
          stepNumber: 3,
          title: 'Kirim Somasi / Teguran Tertulis kepada Penjual',
          detail: 'Bila belanja langsung non-marketplace, hubungi penjual via chat resmi dengan bahasa sopan dan tegas, lampirkan bukti foto/video, serta kutip Pasal 19 UU Perlindungan Konsumen No. 8/1999.',
          practicalTip: 'Beri batas waktu respon wajar 2x24 jam untuk pengembalian dana atau penggantian barang.',
        ),
        SopStep(
          stepNumber: 4,
          title: 'Blokir Rekening Penipu via Lapor.go.id & Cekrekening.id',
          detail: 'Jika penjual memblokir kontak Anda (indikasi penipuan murni), segera laporkan nomor rekening bank pelaku ke portal cekrekening.id resmi Komdigi dan kantor cabang bank terkait untuk pembekuan saldo.',
          warning: 'Sertakan nomor laporan polisi (STPL) dari Polsek setempat agar bank dapat mempercepat blokir.',
        ),
        SopStep(
          stepNumber: 5,
          title: 'Gugat ke BPSK (Badan Penyelesaian Sengketa Konsumen)',
          detail: 'Untuk sengketa nilai besar (elektronik, kendaraan, perumahan, asuransi), daftarkan sengketa konsumen ke kantor BPSK kota/kabupaten. BPSK menyidangkan sengketa secara konsiliasi, mediasi, atau arbitrase cepat tanpa biaya perkara.',
        ),
      ],
    ),
    SopGuide(
      id: 'sop-kebocoran-pdp',
      title: 'SOP Respon 72 Jam Kebocoran Data Pribadi (UU PDP)',
      category: RuleCategory.privacy,
      targetScenario: 'Data pribadi (NIK, password, kartu kredit, email) terindikasi bocor di internet atau terkena serangan peretasan.',
      legalBasis: 'UU No. 27 Tahun 2022 tentang Perlindungan Data Pribadi (UU PDP)',
      rightsSummary: [
        'Korban kebocoran data berhak menerima klarifikasi tertulis dari korporasi pengendali data',
        'Pengendali data wajib menuntaskan notifikasi resmi maksimal 72 jam sejak insiden terdeteksi',
        'Subjek data berhak menuntut ganti rugi perdata atas kerugian akibat kebocoran',
        'Berhak mengajukan pengaduan pelanggaran privasi ke Lembaga Pengawas Perlindungan Data Pribadi / Komdigi',
      ],
      emergencyContacts: [
        EmergencyContact(name: 'Aduan Konten Komdigi', contactNumber: '0811-9224-545', note: 'WhatsApp Helpdesk Keamanan Siber Komdigi'),
        EmergencyContact(name: 'BSSN Tanggap Insiden Siber', contactNumber: '021-78833701', note: 'Badan Siber dan Sandi Negara (CSIRT)'),
      ],
      steps: [
        SopStep(
          stepNumber: 1,
          title: 'Putus Sesi Login & Ganti Seluruh Kata Sandi (1 Jam Pertama)',
          detail: 'Segera ubah password email utama dan seluruh akun media sosial/finansial yang menggunakan kombinasi password serupa. Gunakan tombol "Sign out from all devices" pada menu keamanan.',
          practicalTip: 'Gunakan kata sandi unik minimal 12 karakter kombinasi huruf besar, kecil, angka, dan simbol.',
        ),
        SopStep(
          stepNumber: 2,
          title: 'Aktifkan 2-Factor Authentication (2FA) Berbasis Aplikasi',
          detail: 'Pasang aplikasi Google Authenticator atau Microsoft Authenticator sebagai kunci ganda. Hindari 2FA SMS bila memungkinkan untuk mencegah penyadapan SIM Swap.',
          warning: 'Jangan pernah membagikan kode OTP atau 6 digit token kepada siapapun termasuk pihak yang mengaku petugas bank.',
        ),
        SopStep(
          stepNumber: 3,
          title: 'Amankan Akun Perbankan & Kartu Pembayaran',
          detail: 'Buka aplikasi mobile banking Anda, kunci sementara (freeze) fitur transaksi online kartu debit/kredit, dan periksa histori mutasi terakhir. Hubungi call center bank resmi jika menemukan transaksi asing sekecil apapun.',
        ),
        SopStep(
          stepNumber: 4,
          title: 'Kirim Permintaan Klarifikasi Resmi ke Pengendali Data',
          detail: 'Kirim email resmi kepada DPO (Data Protection Officer) perusahaan terkait. Tanyakan jenis data apa saja yang bocor dan langkah mitigasi yang telah mereka ambil sesuai Pasal 46 UU PDP.',
          practicalTip: 'Simpan balasan email perusahaan sebagai bukti otentik pertanggungjawaban hukum.',
        ),
        SopStep(
          stepNumber: 5,
          title: 'Waspadai Phishing Berkelanjutan & Telepon Spam',
          detail: 'Data nomor telepon dan NIK yang bocor biasanya akan dimanfaatkan sindikat penipuan untuk social engineering lanjutan (menghubungi dengan mengaku polisi, kurir paket, atau keluarga kecelakaan). Jangan panik dan selalu verifikasi.',
        ),
      ],
    ),
    SopGuide(
      id: 'sop-k3-kecelakaan',
      title: 'SOP Evakuasi & Penanganan Kecelakaan Kerja (K3)',
      category: RuleCategory.safety,
      targetScenario: 'Terjadi kecelakaan kerja fatal, luka bakar, tertimpa benda berat, atau evakuasi kebakaran di tempat kerja.',
      legalBasis: 'UU No. 1 Tahun 1970 jo. Permenakertrans No. 03/MEN/1998',
      rightsSummary: [
        'Korban kecelakaan kerja berhak menerima pertolongan pertama (P3K) segera tanpa penundaan',
        'Biaya pengobatan di RS PLKK ditanggung penuh oleh BPJS Ketenagakerjaan',
        'Pengurus wajib melaporkan insiden ke Disnaker dalam waktu maksimal 2x24 jam',
        'Pekerja dilarang diintimidasi untuk menutupi kecelakaan demi bonus jam kerja selamat (zero accident palsu)',
      ],
      emergencyContacts: [
        EmergencyContact(name: 'Ambulans Darurat PMI', contactNumber: '118', note: 'Layanan Ambulans Medis Darurat Nasional'),
        EmergencyContact(name: 'Pemadam Kebakaran (Damkar)', contactNumber: '113', note: 'Evakuasi Kebakaran & Penyelamatan Khusus'),
      ],
      steps: [
        SopStep(
          stepNumber: 1,
          title: 'Amankan Diri Sendiri & Area Sekitar (Prinsip 3A)',
          detail: 'Terapkan prinsip Aman Diri, Aman Pasien, dan Aman Lingkungan. Matikan sumber arus listrik, gas, atau mesin berbahaya sebelum mendekati korban agar Anda tidak menjadi korban berikutnya.',
          warning: 'Jangan memindahkan korban yang dicurigai patah tulang leher/punggung kecuali dalam bahaya ledakan langsung.',
        ),
        SopStep(
          stepNumber: 2,
          title: 'Hubungi Petugas P3K & Layanan Darurat 118',
          detail: 'Berteriaklah meminta bantuan rekan kerja terdekat untuk membawakan kotak P3K dan memanggil First Aider bersertifikat perusahaan. Hubungi ambulans 118 dengan menyebutkan lokasi detail, kondisi korban, dan jenis cedera.',
        ),
        SopStep(
          stepNumber: 3,
          title: 'Lakukan Pertolongan Pertama Sesuai Jenis Luka',
          detail: 'Hentikan pendarahan hebat dengan menekan luka memakai kain steril. Jika korban tidak bernapas dan tidak ada denyut nadi, First Aider wajib segera memulai CPR (Resusitasi Jantung Paru).',
          practicalTip: 'Gunakan sarung tangan medis lateks untuk mencegah penularan penyakit melalui cairan darah.',
        ),
        SopStep(
          stepNumber: 4,
          title: 'Rujuk Korban ke Rumah Sakit Mitra PLKK BPJS',
          detail: 'Bawa korban ke RS atau klinik yang memiliki logo PLKK (Pusat Layanan Kecelakaan Kerja) BPJS Ketenagakerjaan. Tunjukkan kartu peserta BPJS/NIK KTP agar penanganan medis bebas biaya tanpa plafon.',
        ),
        SopStep(
          stepNumber: 5,
          title: 'Isi Formulir Laporan Kecelakaan Kerja Tahap I Disnaker',
          detail: 'Bagian HRD/K3 wajib mengisi Formulir BPJS TK 3 (Laporan Kecelakaan Kerja Tahap I) dan melayangkannya ke kantor Disnaker serta BPJS Ketenagakerjaan dalam kurun waktu 2x24 jam setelah kejadian.',
        ),
      ],
    ),
  ];

  // --- CHECKLIST AUDIT KEPATUHAN (COMPLIANCE AUDIT) ---
  static const List<ComplianceChecklist> checklists = [
    ComplianceChecklist(
      id: 'chk-kendaraan',
      title: 'Audit Kelaikan Berkendara & Dokumen Legalitas',
      category: RuleCategory.traffic,
      targetAudience: 'Pengemudi Sepeda Motor & Mobil Pribadi',
      description: 'Pemeriksaan rutin pra-perjalanan untuk memastikan kepatuhan hukum jalan raya dan mencegah tilang operasi razia.',
      items: [
        ChecklistItem(
          id: 'v1',
          title: 'Masa Berlaku SIM Masih Aktif',
          description: 'SIM sesuai golongan kendaraan (SIM A untuk mobil, SIM C untuk motor) dan belum kedaluwarsa.',
          legalBasis: 'Pasal 281 & 288 ayat (2) UU 22/2009',
          isCrucial: true,
        ),
        ChecklistItem(
          id: 'v2',
          title: 'STNK Asli & Pajak Tahunan Sah',
          description: 'Lembar STNK asli tersimpan rapi dan lembar pengesahan pajak tahunan telah dicap/divalidasi.',
          legalBasis: 'Pasal 288 ayat (1) UU 22/2009',
          isCrucial: true,
        ),
        ChecklistItem(
          id: 'v3',
          title: 'Plat Nomor (TNKB) Terpasang Sesuai Standar',
          description: 'TNKB asli depan dan belakang terpasang kokoh, tidak dimodifikasi miring, dan tidak ditutup mika gelap.',
          legalBasis: 'Pasal 280 UU 22/2009',
          isCrucial: false,
        ),
        ChecklistItem(
          id: 'v4',
          title: 'Helm Berlogo SNI & Tali Pengunci Berfungsi',
          description: 'Helm memiliki sertifikasi SNI timbul, kaca bening tidak buram, dan tali pengikat berbunyi klik.',
          legalBasis: 'Pasal 291 UU 22/2009',
          isCrucial: true,
        ),
        ChecklistItem(
          id: 'v5',
          title: 'Lampu Utama, Rem, & Sein Berfungsi Normal',
          description: 'Lampu depan menyala terang, lampu rem menyala saat tuas ditarik, dan kedua lampu sein berkedip normal.',
          legalBasis: 'Pasal 285 & 293 UU 22/2009',
          isCrucial: true,
        ),
        ChecklistItem(
          id: 'v6',
          title: 'Spion Lengkap Kiri dan Kanan',
          description: 'Kaca spion ganda terpasang pada stang/pintu dan memberikan pandangan sudut buta (blindspot) yang jelas.',
          legalBasis: 'Pasal 285 ayat (1) UU 22/2009',
          isCrucial: false,
        ),
        ChecklistItem(
          id: 'v7',
          title: 'Knalpot Sesuai Standar Ambang Batas Desibel',
          description: 'Knalpot memiliki tabung peredam suara bawaan pabrikan dan tidak menggunakan knalpot pipa brong bising.',
          legalBasis: 'Pasal 285 ayat (1) jo. Permen LHK 56/2019',
          isCrucial: true,
        ),
        ChecklistItem(
          id: 'v8',
          title: 'Sabuk Pengaman & Segitiga Pengaman (Untuk Mobil)',
          description: 'Sabuk keselamatan berfungsi mengunci saat ditarik sentak, ban cadangan bertekanan baik, dan dongkrak tersedia.',
          legalBasis: 'Pasal 289 & 298 UU 22/2009',
          isCrucial: false,
        ),
      ],
    ),
    ComplianceChecklist(
      id: 'chk-pekerja',
      title: 'Audit Hak Normatif Ketenagakerjaan',
      category: RuleCategory.labor,
      targetAudience: 'Pekerja Formal, Karyawan Swasta, & Pekerja Kontrak',
      description: 'Audit mandiri untuk memastikan hak-hak hukum dasar Anda di tempat kerja telah dipenuhi oleh perusahaan sesuai UU.',
      items: [
        ChecklistItem(
          id: 'l1',
          title: 'Pegang Salinan Kontrak Kerja Tertulis Resmi',
          description: 'Pekerja memegang satu rangkap asli kontrak kerja (PKWT atau PKWTT) bertandatangan di atas meterai.',
          legalBasis: 'UU No. 13/2003 Pasal 54 jo. PP 35/2021',
          isCrucial: true,
        ),
        ChecklistItem(
          id: 'l2',
          title: 'Upah Pokok Minimal Setara UMK / UMP',
          description: 'Gaji bulanan tidak lebih rendah dari batas Upah Minimum Kota/Kabupaten yang ditetapkan Gubernur.',
          legalBasis: 'PP No. 36/2021 jo. PP 51/2023',
          isCrucial: true,
        ),
        ChecklistItem(
          id: 'l3',
          title: 'Perhitungan Upah Lembur Sesuai Rumus PP 35/2021',
          description: 'Kelebihan jam kerja di atas 40 jam per minggu dibayarkan dengan kompensasi upah lembur resmi, bukan uang makan semata.',
          legalBasis: 'PP No. 35/2021 Pasal 26 s.d. 31',
          isCrucial: true,
        ),
        ChecklistItem(
          id: 'l4',
          title: 'Kartu Peserta BPJS Ketenagakerjaan & BPJS Kesehatan Aktif',
          description: 'Perusahaan telah mendaftarkan dan rutin menyetorkan premi program JKK, JKM, JHT, JP, dan JKN.',
          legalBasis: 'UU No. 24/2011 Pasal 15',
          isCrucial: true,
        ),
        ChecklistItem(
          id: 'l5',
          title: 'Hak Cuti Tahunan 12 Hari Kerja Dibayar Penuh',
          description: 'Pekerja dengan masa kerja 12 bulan terus menerus berhak mengambil 12 hari cuti tanpa pemotongan gaji pokok.',
          legalBasis: 'UU Cipta Kerja No. 6/2023 Pasal 79',
          isCrucial: false,
        ),
        ChecklistItem(
          id: 'l6',
          title: 'Hak Cuti Bersalin 3 Bulan bagi Pekerja Perempuan',
          description: 'Cuti istirahat melahirkan 1,5 bulan sebelum dan 1,5 bulan setelah persalinan dengan upah dibayar penuh.',
          legalBasis: 'UU No. 13/2003 Pasal 82',
          isCrucial: false,
        ),
        ChecklistItem(
          id: 'l7',
          title: 'Uang Kompensasi Akhir Kontrak bagi PKWT',
          description: 'Pekerja kontrak menerima uang kompensasi pada saat berakhirnya kontrak atau perpanjangan kontrak.',
          legalBasis: 'PP No. 35/2021 Pasal 15',
          isCrucial: true,
        ),
      ],
    ),
    ComplianceChecklist(
      id: 'chk-k3',
      title: 'Audit Standar Keselamatan & K3 Lingkungan Kerja',
      category: RuleCategory.safety,
      targetAudience: 'Supervisor, Pengurus Tempat Kerja, & Anggota P2K3',
      description: 'Pemeriksaan kepatuhan fasilitas fisik, jalur evakuasi, dan perlindungan APD di tempat kerja.',
      items: [
        ChecklistItem(
          id: 's1',
          title: 'Alat Pemadam Api Ringan (APAR) Terpasang & Terisi',
          description: 'APAR berada di posisi ketinggian 120 cm dari lantai, jarum manometer berada di zona hijau, dan belum kedaluwarsa.',
          legalBasis: 'Permenaker No. 04/MEN/1980',
          isCrucial: true,
        ),
        ChecklistItem(
          id: 's2',
          title: 'Pintu Darurat Bebas Gembok & Tidak Terhalang',
          description: 'Pintu keluar darurat membuka ke arah jalur keluar dan tidak terhalang tumpukan palet atau barang gudang.',
          legalBasis: 'Permenaker No. 186/1999',
          isCrucial: true,
        ),
        ChecklistItem(
          id: 's3',
          title: 'Kotak P3K Terisi Lengkap Sesuai Tipe Gedung',
          description: 'Kotak P3K memiliki daftar inventaris obat, kasa steril, plester, bidai, dan cairan antiseptik terverifikasi.',
          legalBasis: 'Permenakertrans No. 15/2008',
          isCrucial: false,
        ),
        ChecklistItem(
          id: 's4',
          title: 'Alat Pelindung Diri (APD) Bersertifikasi SNI/EN',
          description: 'APD dibagikan gratis kepada tenaga kerja sesuai matriks risiko bahaya (helm, kacamata, rompi, sepatu).',
          legalBasis: 'Permenakertrans No. 8/2010',
          isCrucial: true,
        ),
        ChecklistItem(
          id: 's5',
          title: 'Pemasangan Safety Sign & Rambu Bahaya Terbaca',
          description: 'Rambu bahaya tegangan tinggi, zona wajib APD, dan arah evakuasi terpasang dengan warna kontras standar.',
          legalBasis: 'UU No. 1/1970 Pasal 14',
          isCrucial: false,
        ),
      ],
    ),
    ComplianceChecklist(
      id: 'chk-pdp',
      title: 'Audit Privasi Data Pribadi & Keamanan Digital',
      category: RuleCategory.privacy,
      targetAudience: 'Pengguna Smartphone, Praktisi Bisnis, & Pengelola Akun',
      description: 'Checklist keamanan siber mandiri untuk mencegah pembobolan akun, pinjol ilegal, dan pelanggaran UU PDP.',
      items: [
        ChecklistItem(
          id: 'p1',
          title: 'Aktifkan 2FA (Two-Factor Authentication) pada Email Utama',
          description: 'Akun email Gmail/Outlook dilindungi kode verifikasi aplikasi authenticator di samping password.',
          legalBasis: 'Standar Kemanan ISO 27001 & UU PDP Pasal 35',
          isCrucial: true,
        ),
        ChecklistItem(
          id: 'p2',
          title: 'Tidak Ada Foto KTP / Kartu Keluarga Tanpa Watermark',
          description: 'Semua foto berkas identitas yang dikirimkan untuk keperluan verifikasi telah diberi watermark teks tujuan dan tanggal.',
          legalBasis: 'UU No. 27/2022 Pasal 65',
          isCrucial: true,
        ),
        ChecklistItem(
          id: 'p3',
          title: 'Audit Izin Akses Aplikasi Smartphone (Permissions)',
          description: 'Izin akses kontak, mikrofon, dan kamera hanya diberikan pada aplikasi komunikasi yang benar-benar membutuhkan.',
          legalBasis: 'UU No. 27/2022 Pasal 20',
          isCrucial: false,
        ),
        ChecklistItem(
          id: 'p4',
          title: 'Password Finansial Tidak Sama dengan Password Medsos',
          description: 'PIN dan password m-banking menggunakan kombinasi yang sama sekali berbeda dari akun belanja atau game.',
          legalBasis: 'POJK No. 11/POJK.03/2022',
          isCrucial: true,
        ),
        ChecklistItem(
          id: 'p5',
          title: 'Kunci Pengaman Layar (PIN / Biometrik Fingerprint) Aktif',
          description: 'Perangkat smartphone otomatis terkunci dalam waktu 30 detik saat tidak digunakan.',
          legalBasis: 'UU PDP Kewajiban Perlindungan Teknis Data',
          isCrucial: true,
        ),
      ],
    ),
  ];
}
