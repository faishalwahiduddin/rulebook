import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rulebook/core/models/rule_category.dart';
import 'package:rulebook/core/models/rule_item.dart';
import 'package:rulebook/core/storage/rules_database.dart';
import 'package:rulebook/core/utils/l10n_helpers.dart';
import 'package:rulebook/l10n/app_localizations.dart';

void main() {
  group('Rule Localization Tests', () {
    test('Maps seed rules to English correctly', () async {
      final l10nEn = await AppLocalizations.delegate.load(const Locale('en'));
      final rules = RulesDatabase.rules;

      final traffic01 = rules.firstWhere((r) => r.id == 'traffic-01');
      expect(traffic01.localizedTitle(l10nEn), 'Highway & Arterial Speed Limits');
      expect(traffic01.localizedPenalty(l10nEn), contains('2 months imprisonment'));
      expect(traffic01.localizedSummary(l10nEn), contains('100 km/h'));
      expect(traffic01.localizedDos(l10nEn), isNotEmpty);
      expect(traffic01.localizedDonts(l10nEn), isNotEmpty);

      final labor01 = rules.firstWhere((r) => r.id == 'labor-01');
      expect(labor01.localizedTitle(l10nEn), contains('Overtime Wage Calculation'));

      final privacy01 = rules.firstWhere((r) => r.id == 'privacy-01');
      expect(privacy01.localizedTitle(l10nEn), contains('Online Defamation'));

      final consumer01 = rules.firstWhere((r) => r.id == 'consumer-01');
      expect(consumer01.localizedTitle(l10nEn), contains('Compensation for Defective Goods'));

      final safety01 = rules.firstWhere((r) => r.id == 'safety-01');
      expect(safety01.localizedTitle(l10nEn), contains('Fire Extinguisher'));

      final ethics01 = rules.firstWhere((r) => r.id == 'ethics-01');
      expect(ethics01.localizedTitle(l10nEn), contains('Ban on Gratuities'));
    });

    test('Maps seed rules to Indonesian correctly', () async {
      final l10nId = await AppLocalizations.delegate.load(const Locale('id'));
      final rules = RulesDatabase.rules;

      final traffic01 = rules.firstWhere((r) => r.id == 'traffic-01');
      expect(traffic01.localizedTitle(l10nId), 'Batas Kecepatan Jalan Tol & Arteri');
      expect(traffic01.localizedPenalty(l10nId), contains('kurungan paling lama 2 bulan'));
    });

    test('All 8 locales provide non-empty localized titles and penalties for all 31 seed rules', () async {
      final locales = ['id', 'en', 'ar', 'es', 'ja', 'jv', 'su', 'zh'];
      final rules = RulesDatabase.rules;

      for (final code in locales) {
        final l10n = await AppLocalizations.delegate.load(Locale(code));
        for (final rule in rules) {
          final title = rule.localizedTitle(l10n);
          final summary = rule.localizedSummary(l10n);
          final penalty = rule.localizedPenalty(l10n);
          final explanation = rule.localizedExplanation(l10n);
          final dos = rule.localizedDos(l10n);
          final donts = rule.localizedDonts(l10n);

          expect(title, isNotEmpty, reason: 'Empty title for ${rule.id} in $code');
          expect(summary, isNotEmpty, reason: 'Empty summary for ${rule.id} in $code');
          expect(penalty, isNotEmpty, reason: 'Empty penalty for ${rule.id} in $code');
          expect(explanation, isNotEmpty, reason: 'Empty explanation for ${rule.id} in $code');
          expect(dos, isNotEmpty, reason: 'Empty dos for ${rule.id} in $code');
          expect(donts, isNotEmpty, reason: 'Empty donts for ${rule.id} in $code');
        }
      }
    });

    test('Unmapped rule falls back to default model properties', () async {
      final l10nEn = await AppLocalizations.delegate.load(const Locale('en'));
      const customRule = RuleItem(
        id: 'custom-99',
        title: 'Custom Title',
        category: RuleCategory.traffic,
        summary: 'Custom Summary',
        fullExplanation: 'Custom Explanation',
        legalBasis: 'Custom Basis',
        penaltyOrRight: 'Custom Penalty',
        keyDos: ['Custom Do'],
        keyDonts: ['Custom Don\'t'],
        keywords: ['custom'],
      );

      expect(customRule.localizedTitle(l10nEn), 'Custom Title');
      expect(customRule.localizedSummary(l10nEn), 'Custom Summary');
      expect(customRule.localizedPenalty(l10nEn), 'Custom Penalty');
      expect(customRule.localizedExplanation(l10nEn), 'Custom Explanation');
      expect(customRule.localizedDos(l10nEn), ['Custom Do']);
      expect(customRule.localizedDonts(l10nEn), ['Custom Don\'t']);
      expect(customRule.localizedTitle(null), 'Custom Title');
    });

    test('UI strings are present and localized across locales', () async {
      final l10nEn = await AppLocalizations.delegate.load(const Locale('en'));
      expect(l10nEn.shareRuleCard, 'Share Rule Card');
      expect(l10nEn.tierNew, 'Novice');
      expect(l10nEn.tierExpert, 'Regulatory Expert');

      final l10nId = await AppLocalizations.delegate.load(const Locale('id'));
      expect(l10nId.shareRuleCard, 'Bagikan Kartu Aturan');
      expect(l10nId.tierNew, 'Pemula');
      expect(l10nId.tierExpert, 'Pakar Regulasi');
    });
  });
}
