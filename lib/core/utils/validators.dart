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
}
