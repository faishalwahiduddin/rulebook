import '../constants/app_constants.dart';

class AppValidators {
  /// Validates search query input
  static String? validateSearchQuery(String? query) {
    if (query == null || query.trim().isEmpty) {
      return null; // Empty search is acceptable (shows all)
    }
    if (query.trim().length > AppConstants.maxSearchLength) {
      return 'Kata kunci maksimal ${AppConstants.maxSearchLength} karakter';
    }
    return null;
  }

  /// Validates personal note input for a rule (§VAL)
  static String? validateNoteText(String? note) {
    if (note == null || note.trim().isEmpty) {
      return 'Catatan tidak boleh kosong';
    }
    if (note.trim().length > AppConstants.maxNoteLength) {
      return 'Catatan maksimal ${AppConstants.maxNoteLength} karakter';
    }
    return null;
  }

  /// Validates rule identifier
  static String? validateRuleId(String? ruleId) {
    if (ruleId == null || ruleId.trim().isEmpty) {
      return 'ID aturan tidak valid';
    }
    return null;
  }

  /// Validates salary amount input (§VAL)
  static String? validateSalary(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Gaji pokok bulanan wajib diisi';
    }
    final clean = value.replaceAll(RegExp(r'[^0-9]'), '');
    final num = double.tryParse(clean);
    if (num == null) {
      return 'Nominal gaji harus berupa angka valid';
    }
    if (num < 100000) {
      return 'Gaji pokok minimal Rp 100.000';
    }
    if (num > 1000000000) {
      return 'Gaji pokok melebihi batas wajar simulasi (maksimal Rp 1 Miliar)';
    }
    return null;
  }

  /// Validates overtime hours input (§VAL)
  static String? validateOvertimeHours(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Total jam lembur wajib diisi';
    }
    final hours = double.tryParse(value.trim());
    if (hours == null) {
      return 'Jam lembur harus berupa angka numerik';
    }
    if (hours <= 0) {
      return 'Jam lembur harus lebih besar dari 0';
    }
    if (hours > 100) {
      return 'Jam lembur maksimal 100 jam per periode hitung';
    }
    return null;
  }

  /// Validates tenure years input (§VAL)
  static String? validateTenureYears(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Masa kerja (tahun) wajib diisi';
    }
    final years = int.tryParse(value.trim());
    if (years == null) {
      return 'Tahun masa kerja harus berupa bilangan bulat';
    }
    if (years < 0) {
      return 'Tahun masa kerja tidak boleh negatif';
    }
    if (years > 60) {
      return 'Tahun masa kerja maksimal 60 tahun';
    }
    return null;
  }

  /// Validates tenure months input (§VAL)
  static String? validateTenureMonths(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // optional, can default to 0
    }
    final months = int.tryParse(value.trim());
    if (months == null) {
      return 'Bulan masa kerja harus berupa bilangan bulat';
    }
    if (months < 0 || months > 11) {
      return 'Bulan masa kerja harus antara 0 dan 11 bulan';
    }
    return null;
  }
}

