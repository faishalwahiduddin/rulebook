import '../../l10n/app_localizations.dart';
import '../models/compliance_checklist.dart';

extension LocalizedChecklist on ComplianceChecklist {
  String localizedTitle(AppLocalizations? l10n) {
    if (l10n == null) return title;
    return switch (id) {
      'chk-kendaraan' => l10n.chkVehicleTitle,
      'chk-pekerja' => l10n.chkWorkerTitle,
      'chk-k3' => l10n.chkSafetyTitle,
      'chk-pdp' => l10n.chkPrivacyTitle,
      _ => title,
    };
  }

  String localizedAudience(AppLocalizations? l10n) {
    if (l10n == null) return targetAudience;
    return switch (id) {
      'chk-kendaraan' => l10n.chkVehicleAudience,
      'chk-pekerja' => l10n.chkWorkerAudience,
      'chk-k3' => l10n.chkSafetyAudience,
      'chk-pdp' => l10n.chkPrivacyAudience,
      _ => targetAudience,
    };
  }

  String localizedDescription(AppLocalizations? l10n) {
    if (l10n == null) return description;
    return switch (id) {
      'chk-kendaraan' => l10n.chkVehicleDesc,
      'chk-pekerja' => l10n.chkWorkerDesc,
      'chk-k3' => l10n.chkSafetyDesc,
      'chk-pdp' => l10n.chkPrivacyDesc,
      _ => description,
    };
  }
}
