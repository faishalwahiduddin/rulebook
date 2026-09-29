import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../utils/validators.dart';
import '../utils/backup_codec.dart';

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

  Future<bool> saveBookmarks(Set<String> bookmarks) async {
    return _prefs.setStringList(AppConstants.keyBookmarks, bookmarks.toList());
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

  ThemeMode getThemeMode() {
    final mode = _prefs.getString('theme_mode');
    if (mode == 'light') return ThemeMode.light;
    if (mode == 'dark') return ThemeMode.dark;
    return ThemeMode.system;
  }

  Future<bool> saveThemeMode(ThemeMode mode) async {
    final str = mode == ThemeMode.light ? 'light' : (mode == ThemeMode.dark ? 'dark' : 'system');
    return _prefs.setString('theme_mode', str);
  }

  String exportBackupJson() {
    final data = {
      'app': 'RuleBook',
      'version': AppConstants.appVersion,
      'exported_at': DateTime.now().toIso8601String(),
      'bookmarks': getBookmarks().toList(),
      'notes': getAllNotes(),
    };
    return FleetBackupCodec.encode(appTag: 'RULEBOOK', data: data);
  }

  Future<bool> restoreFromBackup(String encoded) async {
    try {
      final data = FleetBackupCodec.decode(appTag: 'RULEBOOK', encoded: encoded);
      if (data.containsKey('bookmarks') && data['bookmarks'] is List) {
        final bookmarks = (data['bookmarks'] as List).cast<String>().toSet();
        await saveBookmarks(bookmarks);
      }
      if (data.containsKey('notes') && data['notes'] is Map) {
        final notes = Map<String, String>.from(data['notes'] as Map);
        for (final entry in notes.entries) {
          await saveNote(entry.key, entry.value);
        }
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> clearAllData() async {
    final keys = _prefs.getKeys();
    for (final k in keys) {
      if (k.startsWith('rulebook_') || k == AppConstants.keyBookmarks) {
        await _prefs.remove(k);
      }
    }
    return true;
  }
}

