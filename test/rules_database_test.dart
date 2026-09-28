import 'package:flutter_test/flutter_test.dart';
import 'package:rulebook/core/models/rule_category.dart';
import 'package:rulebook/core/models/rule_item.dart';
import 'package:rulebook/core/storage/rules_database.dart';

void main() {
  group('RulesDatabase & RuleItem Model Tests', () {
    test('Rules database has valid entries across all categories', () {
      final rules = RulesDatabase.rules;
      expect(rules, isNotEmpty);
      expect(rules.length, greaterThanOrEqualTo(5));

      for (final r in rules) {
        expect(r.id, isNotEmpty);
        expect(r.title, isNotEmpty);
        expect(r.summary, isNotEmpty);
        expect(r.legalBasis, isNotEmpty);
        expect(r.penaltyOrRight, isNotEmpty);
        expect(r.keyDos, isNotEmpty);
        expect(r.keyDonts, isNotEmpty);
      }
    });

    test('RuleItem serialization round-trip', () {
      const original = RuleItem(
        id: 'test-01',
        title: 'Aturan Test',
        category: RuleCategory.traffic,
        summary: 'Ringkasan test',
        fullExplanation: 'Penjelasan lengkap',
        legalBasis: 'UU 1/2026',
        penaltyOrRight: 'Denda Rp 100.000',
        keyDos: ['Lakukan'],
        keyDonts: ['Jangan'],
        keywords: ['test'],
      );

      final json = original.toJson();
      final restored = RuleItem.fromJson(json);

      expect(restored.id, original.id);
      expect(restored.title, original.title);
      expect(restored.category, original.category);
      expect(restored.legalBasis, original.legalBasis);
    });
  });
}
