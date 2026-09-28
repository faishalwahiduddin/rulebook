import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../utils/validators.dart';

class LocalStorageService {
  final SharedPreferences _prefs;

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
