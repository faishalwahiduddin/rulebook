class CyberPenaltyItem {
  final String id;
  final String title;
  final String articleReference;
  final int maxPrisonYears;
  final int maxFineRupiah;
  final bool isComplaintDelict;
  final String description;
  final String publicDefenseExemption;
  final String guidance;

  const CyberPenaltyItem({
    required this.id,
    required this.title,
    required this.articleReference,
    required this.maxPrisonYears,
    required this.maxFineRupiah,
    required this.isComplaintDelict,
    required this.description,
    required this.publicDefenseExemption,
    required this.guidance,
  });
}

class CyberPenaltyDatabase {
  static const List<CyberPenaltyItem> items = [
    CyberPenaltyItem(
      id: 'ite_pencemaran',
      title: 'Pencemaran Nama Baik / Menyerang Kehormatan',
      articleReference: 'UU No. 1 Tahun 2024 Pasal 27A jo. Pasal 45 ayat (4)',
      maxPrisonYears: 2,
      maxFineRupiah: 400000000,
      isComplaintDelict: true,
      description:
          'Menyerang kehormatan atau nama baik orang lain dengan menuduhkan suatu hal melalui sistem elektronik dengan maksud diketahui umum.',
      publicDefenseExemption:
          'Dikecualikan dan TIDAK DIPIDANA jika dilakukan demi kepentingan umum atau terpaksa membela diri.',
      guidance:
          'Kritik terhadap kebijakan publik atau kinerja instansi BUKAN delik pidana. Delik aduan absolut (hanya korban perseorangan langsung yang bisa melapor).',
    ),
    CyberPenaltyItem(
      id: 'ite_pemerasan',
      title: 'Pemerasan / Pengancaman Siber',
      articleReference: 'UU No. 1 Tahun 2024 Pasal 27B jo. Pasal 45 ayat (10)',
      maxPrisonYears: 6,
      maxFineRupiah: 1000000000,
      isComplaintDelict: true,
      description:
          'Mengancam pencemaran atau pembukaan rahasia agar korban memberikan barang/uang atau membuat pengakuan utang.',
      publicDefenseExemption: 'Tidak ada pengecualian pembelaan.',
      guidance:
          'Sering terjadi pada kasus pinjol ilegal atau doxxing foto pribadi. Segera tangkap layar (screenshot) sebagai bukti hukum primer.',
    ),
    CyberPenaltyItem(
      id: 'ite_hoaks_onar',
      title: 'Penyebaran Berita Bohong yang Memicu Keonaran',
      articleReference: 'UU No. 1 Tahun 2024 Pasal 28 ayat (3) jo. Pasal 45A ayat (3)',
      maxPrisonYears: 6,
      maxFineRupiah: 1000000000,
      isComplaintDelict: false,
      description:
          'Menyiarkan informasi bohong yang mengakibatkan kerusuhan fisik atau keonaran di masyarakat luas.',
      publicDefenseExemption: 'Tidak berlaku.',
      guidance:
          'Bukan delik aduan, aparat penegak hukum dapat langsung memproses. Saring sebelum sharing dan periksa cekfakta resmi.',
    ),
    CyberPenaltyItem(
      id: 'ite_penipuan_konsumen',
      title: 'Berita Bohong Merugikan Konsumen (Penipuan Online)',
      articleReference: 'UU No. 1 Tahun 2024 Pasal 28 ayat (1) jo. Pasal 45A ayat (1)',
      maxPrisonYears: 6,
      maxFineRupiah: 1000000000,
      isComplaintDelict: false,
      description:
          'Menyebarkan informasi bohong dalam transaksi elektronik yang mengakibatkan kerugian materiil konsumen.',
      publicDefenseExemption: 'Tidak berlaku.',
      guidance:
          'Mencakup penipuan toko online palsu, phishing perbankan, dan manipulasi promo dagang digital.',
    ),
    CyberPenaltyItem(
      id: 'pdp_jual_beli_data',
      title: 'Memperjualbelikan Data Pribadi Secara Ilegal',
      articleReference: 'UU No. 27 Tahun 2022 (UU PDP) Pasal 65 ayat (2) jo. Pasal 67 ayat (2)',
      maxPrisonYears: 5,
      maxFineRupiah: 5000000000,
      isComplaintDelict: false,
      description:
          'Memperoleh, mengumpulkan, atau memperjualbelikan data pribadi yang bukan miliknya secara melawan hukum.',
      publicDefenseExemption: 'Tidak berlaku.',
      guidance:
          'Berlaku bagi broker data, telemarketer ilegal, atau oknum yang membocorkan database nasabah/konsumen.',
    ),
    CyberPenaltyItem(
      id: 'ite_illegal_access',
      title: 'Akses Ilegal / Peretasan Akun & Sistem (Hacking)',
      articleReference: 'UU No. 11/2008 jo. UU 1/2024 Pasal 30 jo. Pasal 46',
      maxPrisonYears: 8,
      maxFineRupiah: 800000000,
      isComplaintDelict: false,
      description:
          'Mengakses sistem atau akun orang lain tanpa hak dengan cara menerobos atau melanggar pengamanan sandi/OTP.',
      publicDefenseExemption: 'Kecuali ethical hacker dengan izin tertulis resmi pengelola sistem.',
      guidance:
          'Membajak akun WhatsApp, media sosial, atau email orang lain tergolong pidana peretasan akses ilegal.',
    ),
  ];
}
