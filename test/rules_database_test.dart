import 'package:flutter_test/flutter_test.dart';
import 'package:rulebook/core/models/compliance_checklist.dart';
import 'package:rulebook/core/models/cyber_penalty_models.dart';
import 'package:rulebook/core/models/rule_category.dart';
import 'package:rulebook/core/models/rule_item.dart';
import 'package:rulebook/core/models/severance_calculator_models.dart';
import 'package:rulebook/core/models/sop_guide.dart';
import 'package:rulebook/core/storage/rules_database.dart';

void main() {
  group('RulesDatabase & RuleItem Model Tests', () {
    test('Rules database has comprehensive valid entries across all categories', () {
      final rules = RulesDatabase.rules;
      expect(rules, isNotEmpty);
      expect(rules.length, greaterThanOrEqualTo(20));

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

    test('SOP Guides integrity and round-trip serialization', () {
      final sops = RulesDatabase.sopGuides;
      expect(sops, isNotEmpty);
      expect(sops.length, greaterThanOrEqualTo(5));

      for (final sop in sops) {
        expect(sop.id, isNotEmpty);
        expect(sop.title, isNotEmpty);
        expect(sop.targetScenario, isNotEmpty);
        expect(sop.legalBasis, isNotEmpty);
        expect(sop.steps, isNotEmpty);
        expect(sop.rightsSummary, isNotEmpty);

        final json = sop.toJson();
        final restored = SopGuide.fromJson(json);
        expect(restored.id, sop.id);
        expect(restored.title, sop.title);
        expect(restored.steps.length, sop.steps.length);
      }
    });

    test('Compliance Checklists integrity and serialization', () {
      final checklists = RulesDatabase.checklists;
      expect(checklists, isNotEmpty);
      expect(checklists.length, greaterThanOrEqualTo(4));

      for (final chk in checklists) {
        expect(chk.id, isNotEmpty);
        expect(chk.title, isNotEmpty);
        expect(chk.items, isNotEmpty);

        final json = chk.toJson();
        final restored = ComplianceChecklist.fromJson(json);
        expect(restored.id, chk.id);
        expect(restored.items.length, chk.items.length);
      }
    });

    test('SeveranceCalculatorEngine accurately computes PP 35/2021 formula', () {
      final reason = SeveranceCalculatorEngine.reasons.firstWhere((r) => r.id == 'efisiensi_cegah');
      final result = SeveranceCalculatorEngine.calculate(
        monthlyWage: 10000000,
        tenureYears: 3,
        tenureMonths: 6,
        reason: reason,
        manualUph: 1500000,
      );

      // Tenure 3.5 yrs -> 4 months base pesangon, 2 months base upmk
      expect(result.basePesangonMonths, 4);
      expect(result.baseUpmkMonths, 2);
      expect(result.calculatedPesangon, 40000000.0); // 4 * 10jt * 1.0
      expect(result.calculatedUpmk, 20000000.0); // 2 * 10jt * 1.0
      expect(result.totalSeverancePay, 61500000.0); // 40jt + 20jt + 1.5jt
    });

    test('CyberPenaltyDatabase items verify official penalties and delict types', () {
      final items = CyberPenaltyDatabase.items;
      expect(items, isNotEmpty);
      expect(items.length, greaterThanOrEqualTo(5));

      final pencemaran = items.firstWhere((i) => i.id == 'ite_pencemaran');
      expect(pencemaran.isComplaintDelict, isTrue);
      expect(pencemaran.maxPrisonYears, 2);
      expect(pencemaran.maxFineRupiah, 400000000);
    });
  });
}
