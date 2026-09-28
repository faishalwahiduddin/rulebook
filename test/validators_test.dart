import 'package:flutter_test/flutter_test.dart';
import 'package:rulebook/core/utils/validators.dart';

void main() {
  group('RuleBook AppValidators (§VAL)', () {
    test('validateSearchQuery validates length limit', () {
      expect(AppValidators.validateSearchQuery(null), isNull);
      expect(AppValidators.validateSearchQuery(''), isNull);
      expect(AppValidators.validateSearchQuery('tilang'), isNull);
      expect(AppValidators.validateSearchQuery('a' * 65), isNotNull);
    });

    test('validateNoteText rejects empty and validates max length', () {
      expect(AppValidators.validateNoteText(null), isNotNull);
      expect(AppValidators.validateNoteText(''), isNotNull);
      expect(AppValidators.validateNoteText('   '), isNotNull);
      expect(AppValidators.validateNoteText('Pasal ini dipakai saat tilang operasi zebra'), isNull);
      expect(AppValidators.validateNoteText('x' * 550), isNotNull);
    });

    test('validateRuleId rejects empty ID', () {
      expect(AppValidators.validateRuleId(null), isNotNull);
      expect(AppValidators.validateRuleId(''), isNotNull);
      expect(AppValidators.validateRuleId('traffic-01'), isNull);
    });

    test('validateSalary validates reasonable numeric boundaries (§VAL)', () {
      expect(AppValidators.validateSalary(null), isNotNull);
      expect(AppValidators.validateSalary(''), isNotNull);
      expect(AppValidators.validateSalary('abc'), isNotNull);
      expect(AppValidators.validateSalary('50000'), isNotNull); // under 100k
      expect(AppValidators.validateSalary('5000000'), isNull); // 5jt valid
      expect(AppValidators.validateSalary('2000000000'), isNotNull); // over 1Miliar
    });

    test('validateOvertimeHours validates hours limits (§VAL)', () {
      expect(AppValidators.validateOvertimeHours(null), isNotNull);
      expect(AppValidators.validateOvertimeHours('0'), isNotNull);
      expect(AppValidators.validateOvertimeHours('-2'), isNotNull);
      expect(AppValidators.validateOvertimeHours('3.5'), isNull);
      expect(AppValidators.validateOvertimeHours('101'), isNotNull);
    });

    test('validateTenureYears validates tenure limits (§VAL)', () {
      expect(AppValidators.validateTenureYears(null), isNotNull);
      expect(AppValidators.validateTenureYears('-1'), isNotNull);
      expect(AppValidators.validateTenureYears('5'), isNull);
      expect(AppValidators.validateTenureYears('70'), isNotNull);
    });

    test('validateTenureMonths validates months limits (§VAL)', () {
      expect(AppValidators.validateTenureMonths(null), isNull); // optional
      expect(AppValidators.validateTenureMonths(''), isNull);
      expect(AppValidators.validateTenureMonths('6'), isNull);
      expect(AppValidators.validateTenureMonths('12'), isNotNull);
      expect(AppValidators.validateTenureMonths('-1'), isNotNull);
    });
  });
}
