import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rulebook/core/storage/local_storage_service.dart';
import 'package:rulebook/core/utils/backup_codec.dart';

void main() {
  group('RuleBook FleetBackupCodec & Storage Tests', () {
    test('exports and restores backup cleanly, rejects raw json', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final storage = LocalStorageService(prefs);

      await storage.saveBookmarks({'rule-1', 'rule-2'});
      await storage.saveNote('rule-1', 'Catatan penting');

      final backupStr = storage.exportBackupJson();
      expect(backupStr.startsWith('FSBK1#RULEBOOK#'), isTrue);
      expect(backupStr.startsWith('{'), isFalse);

      // Rejects raw json
      final invalid = await storage.restoreFromBackup('{"app": "RuleBook"}');
      expect(invalid, isFalse);

      // Successfully restores
      await storage.clearAllData();
      expect(storage.getBookmarks().isEmpty, isTrue);

      final success = await storage.restoreFromBackup(backupStr);
      expect(success, isTrue);
      expect(storage.getBookmarks().contains('rule-1'), isTrue);
      expect(storage.getNote('rule-1'), 'Catatan penting');
    });
  });
}
