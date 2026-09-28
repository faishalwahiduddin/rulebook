class PhkReason {
  final String id;
  final String title;
  final String legalArticle;
  final double pesangonFactor;
  final double upmkFactor;
  final String description;

  const PhkReason({
    required this.id,
    required this.title,
    required this.legalArticle,
    required this.pesangonFactor,
    required this.upmkFactor,
    required this.description,
  });
}

class SeveranceResult {
  final double monthlyWage;
  final int tenureYears;
  final int tenureMonths;
  final PhkReason reason;
  final int basePesangonMonths;
  final int baseUpmkMonths;
  final double calculatedPesangon;
  final double calculatedUpmk;
  final double compensationRights;
  final double totalSeverancePay;

  const SeveranceResult({
    required this.monthlyWage,
    required this.tenureYears,
    required this.tenureMonths,
    required this.reason,
    required this.basePesangonMonths,
    required this.baseUpmkMonths,
    required this.calculatedPesangon,
    required this.calculatedUpmk,
    required this.compensationRights,
    required this.totalSeverancePay,
  });
}

class SeveranceCalculatorEngine {
  static const List<PhkReason> reasons = [
    PhkReason(
      id: 'efisiensi_rugi',
      title: 'Efisiensi Karena Perusahaan Merugi',
      legalArticle: 'PP 35/2021 Pasal 43 ayat (1)',
      pesangonFactor: 0.5,
      upmkFactor: 1.0,
      description: 'Perusahaan melakukan efisiensi yang disebabkan mengalami kerugian keuangan.',
    ),
    PhkReason(
      id: 'efisiensi_cegah',
      title: 'Efisiensi Pencegahan Kerugian',
      legalArticle: 'PP 35/2021 Pasal 43 ayat (2)',
      pesangonFactor: 1.0,
      upmkFactor: 1.0,
      description: 'Perusahaan melakukan efisiensi untuk mencegah terjadinya potensi kerugian di masa depan.',
    ),
    PhkReason(
      id: 'pensiun',
      title: 'Pekerja Mencapai Usia Pensiun',
      legalArticle: 'PP 35/2021 Pasal 56',
      pesangonFactor: 1.75,
      upmkFactor: 1.0,
      description: 'Pemutusan hubungan kerja karena pekerja telah memasuki usia pensiun sesuai PKB/aturan perusahaan.',
    ),
    PhkReason(
      id: 'force_majeure',
      title: 'Perusahaan Tutup / Force Majeure / Rugi 2 Tahun',
      legalArticle: 'PP 35/2021 Pasal 44 & 45',
      pesangonFactor: 0.5,
      upmkFactor: 1.0,
      description: 'Perusahaan tutup akibat keadaan memaksa (force majeure) atau putusan pailit pengadilan.',
    ),
    PhkReason(
      id: 'sakit_panjang',
      title: 'Sakit Berkepanjangan / Cacat Total Akibat Kerja',
      legalArticle: 'PP 35/2021 Pasal 47',
      pesangonFactor: 2.0,
      upmkFactor: 1.0,
      description: 'Pekerja mengalami sakit berkepanjangan melampaui 12 bulan atau mengalami cacat akibat kecelakaan kerja.',
    ),
    PhkReason(
      id: 'sp3_pelanggaran',
      title: 'Pelanggaran Ketentuan (SP 1, SP 2, SP 3)',
      legalArticle: 'PP 35/2021 Pasal 52 ayat (1)',
      pesangonFactor: 0.5,
      upmkFactor: 1.0,
      description: 'Pekerja melakukan pelanggaran ketentuan dalam perjanjian kerja setelah diberikan surat peringatan berturut-turut.',
    ),
    PhkReason(
      id: 'resign_mandiri',
      title: 'Pengunduran Diri Sukarela (Resign)',
      legalArticle: 'PP 35/2021 Pasal 48',
      pesangonFactor: 0.0,
      upmkFactor: 0.0,
      description: 'Pekerja mengundurkan diri atas kemauan sendiri tanpa paksaan (berhak atas UPH & Uang Pisah bila diatur di PK/PKB).',
    ),
    PhkReason(
      id: 'meninggal_dunia',
      title: 'Pekerja Meninggal Dunia',
      legalArticle: 'PP 35/2021 Pasal 57',
      pesangonFactor: 2.0,
      upmkFactor: 1.0,
      description: 'Kompensasi diberikan kepada ahli waris pekerja yang sah.',
    ),
  ];

  static int getBasePesangonMonths(int years, int months) {
    final totalMonths = (years * 12) + months;
    if (totalMonths < 12) return 1;
    if (totalMonths < 24) return 2;
    if (totalMonths < 36) return 3;
    if (totalMonths < 48) return 4;
    if (totalMonths < 60) return 5;
    if (totalMonths < 72) return 6;
    if (totalMonths < 84) return 7;
    if (totalMonths < 96) return 8;
    return 9; // 8 tahun atau lebih = 9 bulan
  }

  static int getBaseUpmkMonths(int years) {
    if (years < 3) return 0;
    if (years < 6) return 2;
    if (years < 9) return 3;
    if (years < 12) return 4;
    if (years < 15) return 5;
    if (years < 18) return 6;
    if (years < 21) return 7;
    if (years < 24) return 8;
    return 10; // 24 tahun atau lebih = 10 bulan
  }

  static SeveranceResult calculate({
    required double monthlyWage,
    required int tenureYears,
    required int tenureMonths,
    required PhkReason reason,
    double manualUph = 0.0,
  }) {
    final basePesangonMonths = getBasePesangonMonths(tenureYears, tenureMonths);
    final baseUpmkMonths = getBaseUpmkMonths(tenureYears);

    final calculatedPesangon = basePesangonMonths * monthlyWage * reason.pesangonFactor;
    final calculatedUpmk = baseUpmkMonths * monthlyWage * reason.upmkFactor;
    final total = calculatedPesangon + calculatedUpmk + manualUph;

    return SeveranceResult(
      monthlyWage: monthlyWage,
      tenureYears: tenureYears,
      tenureMonths: tenureMonths,
      reason: reason,
      basePesangonMonths: basePesangonMonths,
      baseUpmkMonths: baseUpmkMonths,
      calculatedPesangon: calculatedPesangon,
      calculatedUpmk: calculatedUpmk,
      compensationRights: manualUph,
      totalSeverancePay: total,
    );
  }
}
