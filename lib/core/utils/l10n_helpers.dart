import '../../l10n/app_localizations.dart';
export 'rule_l10n_extension.dart';

String? mapValidationError(String? code, AppLocalizations? l10n) {
  if (code == null) return null;
  if (l10n == null) return code;
  return switch (code) {
    'errorSearchQueryTooLong' => l10n.errorSearchQueryTooLong,
    'errorNoteEmpty' => l10n.errorNoteEmpty,
    'errorNoteTooLong' => l10n.errorNoteTooLong,
    'errorRuleIdInvalid' => l10n.errorRuleIdInvalid,
    'errorSalaryRequired' => l10n.errorSalaryRequired,
    'errorSalaryInvalid' => l10n.errorSalaryInvalid,
    'errorSalaryMin' => l10n.errorSalaryMin,
    'errorSalaryMax' => l10n.errorSalaryMax,
    'errorOvertimeHoursRequired' => l10n.errorOvertimeHoursRequired,
    'errorOvertimeHoursInvalid' => l10n.errorOvertimeHoursInvalid,
    'errorOvertimeHoursMin' => l10n.errorOvertimeHoursMin,
    'errorOvertimeHoursMax' => l10n.errorOvertimeHoursMax,
    'errorTenureYearsRequired' => l10n.errorTenureYearsRequired,
    'errorTenureYearsInvalid' => l10n.errorTenureYearsInvalid,
    'errorTenureYearsMin' => l10n.errorTenureYearsMin,
    'errorTenureYearsMax' => l10n.errorTenureYearsMax,
    'errorTenureMonthsInvalid' => l10n.errorTenureMonthsInvalid,
    'errorTenureMonthsRange' => l10n.errorTenureMonthsRange,
    _ => code,
  };
}

String localeName(AppLocalizations? l10n, String code) {
  if (l10n == null) return code;
  return switch (code) {
    'id' => l10n.localeIndonesian,
    'en' => l10n.localeEnglish,
    'ar' => l10n.localeArabic,
    'jv' => l10n.localeJavanese,
    'su' => l10n.localeSundanese,
    'zh' => l10n.localeChinese,
    'ja' => l10n.localeJapanese,
    'es' => l10n.localeSpanish,
    _ => code,
  };
}
