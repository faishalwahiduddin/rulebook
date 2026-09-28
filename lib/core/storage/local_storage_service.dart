import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../utils/validators.dart';

class LocalStorageService {
  final SharedPreferences _prefs;

  SharedPreferences get prefs => _prefs;

  LocalStorageService(this._prefs);

  static Future<LocalStorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return LocalStorageService(prefs);
  }

  Set<String> getBookmarks() {
    final list = _prefs.getStringList(AppConstants.keyBookmarks) ?? [];
    return list.toSet();
  }

  Future<bool> toggleBookmark(String ruleId) async {
    final err = AppValidators.validateRuleId(ruleId);
    if (err != null) throw ArgumentError(err);

    final bookmarks = getBookmarks();
    if (bookmarks.contains(ruleId)) {
      bookmarks.remove(ruleId);
    } else {
      bookmarks.add(ruleId);
    }
    return _prefs.setStringList(AppConstants.keyBookmarks, bookmarks.toList());
  }

  bool isBookmarked(String ruleId) {
    return getBookmarks().contains(ruleId);
  }

  String? getNote(String ruleId) {
    return _prefs.getString('${AppConstants.keyCustomNotes}_$ruleId');
  }

  Future<bool> saveNote(String ruleId, String note) async {
    final ruleErr = AppValidators.validateRuleId(ruleId);
    if (ruleErr != null) throw ArgumentError(ruleErr);

    final noteErr = AppValidators.validateNoteText(note);
    if (noteErr != null) throw ArgumentError(noteErr);

    return _prefs.setString('${AppConstants.keyCustomNotes}_$ruleId', note.trim());
  }

  Future<bool> deleteNote(String ruleId) async {
    return _prefs.remove('${AppConstants.keyCustomNotes}_$ruleId');
  }

  Map<String, String> getAllNotes() {
    final result = <String, String>{};
    final prefix = '${AppConstants.keyCustomNotes}_';
    for (final key in _prefs.getKeys()) {
      if (key.startsWith(prefix)) {
        final ruleId = key.substring(prefix.length);
        final val = _prefs.getString(key);
        if (val != null && val.isNotEmpty) {
          result[ruleId] = val;
        }
      }
    }
    return result;
  }

  Set<String> getCheckedItems(String checklistId) {
    final list = _prefs.getStringList('rulebook_chk_$checklistId') ?? [];
    return list.toSet();
  }

  Future<bool> toggleChecklistItem(String checklistId, String itemId) async {
    final checked = getCheckedItems(checklistId);
    if (checked.contains(itemId)) {
      checked.remove(itemId);
    } else {
      checked.add(itemId);
    }
    return _prefs.setStringList('rulebook_chk_$checklistId', checked.toList());
  }

  Future<bool> resetChecklist(String checklistId) async {
    return _prefs.remove('rulebook_chk_$checklistId');
  }

  Future<bool> clearAllData() async {
    final keys = _prefs.getKeys();
    for (final k in keys) {
      if (k.startsWith('rulebook_')) {
        await _prefs.remove(k);
      }
    }
    return true;
  }
}

