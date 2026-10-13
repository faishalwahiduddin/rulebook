import '../constants/app_constants.dart';

class AppValidators {
  /// Validates search query input
  static String? validateSearchQuery(String? query) {
    if (query == null || query.trim().isEmpty) {
      return null; // Empty search is acceptable (shows all)
    }
    if (query.trim().length > AppConstants.maxSearchLength) {
      return 'errorSearchQueryTooLong';
    }
    return null;
  }

  /// Validates personal note input for a rule (§VAL)
  static String? validateNoteText(String? note) {
    if (note == null || note.trim().isEmpty) {
      return 'errorNoteEmpty';
    }
    if (note.trim().length > AppConstants.maxNoteLength) {
      return 'errorNoteTooLong';
    }
    return null;
  }

  /// Validates rule identifier
  static String? validateRuleId(String? ruleId) {
    if (ruleId == null || ruleId.trim().isEmpty) {
      return 'errorRuleIdInvalid';
    }
    return null;
  }

  /// Validates salary amount input (§VAL)
  static String? validateSalary(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'errorSalaryRequired';
    }
    final clean = value.replaceAll(RegExp(r'[^0-9]'), '');
    final num = double.tryParse(clean);
    if (num == null) {
      return 'errorSalaryInvalid';
    }
    if (num < 100000) {
      return 'errorSalaryMin';
    }
    if (num > 1000000000) {
      return 'errorSalaryMax';
    }
    return null;
  }

  /// Validates overtime hours input (§VAL)
  static String? validateOvertimeHours(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'errorOvertimeHoursRequired';
    }
    final hours = double.tryParse(value.trim());
    if (hours == null) {
      return 'errorOvertimeHoursInvalid';
    }
    if (hours <= 0) {
      return 'errorOvertimeHoursMin';
    }
    if (hours > 100) {
      return 'errorOvertimeHoursMax';
    }
    return null;
  }

  /// Validates tenure years input (§VAL)
  static String? validateTenureYears(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'errorTenureYearsRequired';
    }
    final years = int.tryParse(value.trim());
    if (years == null) {
      return 'errorTenureYearsInvalid';
    }
    if (years < 0) {
      return 'errorTenureYearsMin';
    }
    if (years > 60) {
      return 'errorTenureYearsMax';
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
      return 'errorTenureMonthsInvalid';
    }
    if (months < 0 || months > 11) {
      return 'errorTenureMonthsRange';
    }
    return null;
  }
}
