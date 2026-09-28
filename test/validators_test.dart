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
  });
}
