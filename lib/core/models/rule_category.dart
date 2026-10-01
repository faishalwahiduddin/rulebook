import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_icons.dart';
import '../../l10n/app_localizations.dart';

/// Domain classification for rules, SOPs and checklists.
///
/// Colors are resolved from the active [AppColors] theme extension rather than
/// baked in, so lights and darks stay legible.
enum RuleCategory {
  all(AppIconData.layers),
  traffic(AppIconData.traffic),
  labor(AppIconData.briefcase),
  privacy(AppIconData.lock),
  consumer(AppIconData.cart),
  safety(AppIconData.hardhat),
  ethics(AppIconData.megaphone);

  final AppIconData icon;

  const RuleCategory(this.icon);

  String localizedLabel(AppLocalizations l10n) {
    switch (this) {
      case RuleCategory.all:
        return l10n.categoryAll;
      case RuleCategory.traffic:
        return l10n.catTraffic;
      case RuleCategory.labor:
        return l10n.catLabor;
      case RuleCategory.privacy:
        return l10n.catCyber;
      case RuleCategory.consumer:
        return l10n.catConsumer;
      case RuleCategory.safety:
        return l10n.catSafety;
      case RuleCategory.ethics:
        return l10n.catCivil;
    }
  }

  /// Short label for compact chips / tab bars.
  String localizedShortLabel(AppLocalizations l10n) {
    switch (this) {
      case RuleCategory.all:
        return l10n.categoryAll;
      case RuleCategory.traffic:
        return l10n.catTrafficShort;
      case RuleCategory.labor:
        return l10n.catLaborShort;
      case RuleCategory.privacy:
        return l10n.catCyberShort;
      case RuleCategory.consumer:
        return l10n.catConsumerShort;
      case RuleCategory.safety:
        return l10n.catSafetyShort;
      case RuleCategory.ethics:
        return l10n.catCivilShort;
    }
  }

  /// One-line, plain-language description of what lives in this category.
  String localizedDescription(AppLocalizations l10n) {
    switch (this) {
      case RuleCategory.all:
        return l10n.catAllDesc;
      case RuleCategory.traffic:
        return l10n.catTrafficDesc;
      case RuleCategory.labor:
        return l10n.catLaborDesc;
      case RuleCategory.privacy:
        return l10n.catCyberDesc;
      case RuleCategory.consumer:
        return l10n.catConsumerDesc;
      case RuleCategory.safety:
        return l10n.catSafetyDesc;
      case RuleCategory.ethics:
        return l10n.catCivilDesc;
    }
  }

  Color accent(AppColors c) {
    switch (this) {
      case RuleCategory.all:
        return c.brand;
      case RuleCategory.traffic:
        return c.catTraffic;
      case RuleCategory.labor:
        return c.catLabor;
      case RuleCategory.privacy:
        return c.catPrivacy;
      case RuleCategory.consumer:
        return c.catConsumer;
      case RuleCategory.safety:
        return c.catSafety;
      case RuleCategory.ethics:
        return c.catEthics;
    }
  }
}
