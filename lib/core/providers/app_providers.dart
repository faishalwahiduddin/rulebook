import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/compliance_checklist.dart';
import '../models/rule_category.dart';
import '../models/rule_item.dart';
import '../models/sop_guide.dart';
import '../storage/local_storage_service.dart';
import '../storage/rules_database.dart';
import '../utils/validators.dart';

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  throw UnimplementedError('localStorageServiceProvider must be provided');
});

final allRulesProvider = Provider<List<RuleItem>>((ref) {
  return RulesDatabase.rules;
});

final allSopGuidesProvider = Provider<List<SopGuide>>((ref) {
  return RulesDatabase.sopGuides;
});

final allChecklistsProvider = Provider<List<ComplianceChecklist>>((ref) {
  return RulesDatabase.checklists;
});

class SelectedCategoryNotifier extends Notifier<RuleCategory> {
  @override
  RuleCategory build() => RuleCategory.all;

  void selectCategory(RuleCategory category) {
    state = category;
  }
}

final selectedCategoryProvider =
    NotifierProvider<SelectedCategoryNotifier, RuleCategory>(SelectedCategoryNotifier.new);

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String query) {
    final err = AppValidators.validateSearchQuery(query);
    if (err == null) {
      state = query;
    }
  }

  void clear() {
    state = '';
  }
}

final searchQueryProvider =
    NotifierProvider<SearchQueryNotifier, String>(SearchQueryNotifier.new);

class BookmarksNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() {
    final storage = ref.watch(localStorageServiceProvider);
    return storage.getBookmarks();
  }

  Future<void> toggleBookmark(String ruleId) async {
    final storage = ref.read(localStorageServiceProvider);
    await storage.toggleBookmark(ruleId);
    state = storage.getBookmarks();
  }
}

final bookmarksProvider =
    NotifierProvider<BookmarksNotifier, Set<String>>(BookmarksNotifier.new);

class RuleNotesNotifier extends Notifier<Map<String, String>> {
  @override
  Map<String, String> build() {
    final storage = ref.watch(localStorageServiceProvider);
    return storage.getAllNotes();
  }

  Future<void> saveNote(String ruleId, String text) async {
    final storage = ref.read(localStorageServiceProvider);
    await storage.saveNote(ruleId, text);
    state = storage.getAllNotes();
  }

  Future<void> deleteNote(String ruleId) async {
    final storage = ref.read(localStorageServiceProvider);
    await storage.deleteNote(ruleId);
    state = storage.getAllNotes();
  }
}

final ruleNotesProvider =
    NotifierProvider<RuleNotesNotifier, Map<String, String>>(RuleNotesNotifier.new);

final filteredRulesProvider = Provider<List<RuleItem>>((ref) {
  final allRules = ref.watch(allRulesProvider);
  final category = ref.watch(selectedCategoryProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();

  return allRules.where((rule) {
    final matchesCategory = category == RuleCategory.all || rule.category == category;
    if (!matchesCategory) return false;

    if (query.isEmpty) return true;

    final inTitle = rule.title.toLowerCase().contains(query);
    final inSummary = rule.summary.toLowerCase().contains(query);
    final inLegal = rule.legalBasis.toLowerCase().contains(query);
    final inKeywords = rule.keywords.any((k) => k.toLowerCase().contains(query));

    return inTitle || inSummary || inLegal || inKeywords;
  }).toList();
});

final filteredSopGuidesProvider = Provider<List<SopGuide>>((ref) {
  final allSops = ref.watch(allSopGuidesProvider);
  final category = ref.watch(selectedCategoryProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();

  return allSops.where((sop) {
    final matchesCategory = category == RuleCategory.all || sop.category == category;
    if (!matchesCategory) return false;

    if (query.isEmpty) return true;

    final inTitle = sop.title.toLowerCase().contains(query);
    final inScenario = sop.targetScenario.toLowerCase().contains(query);
    final inLegal = sop.legalBasis.toLowerCase().contains(query);

    return inTitle || inScenario || inLegal;
  }).toList();
});

class ChecklistStateNotifier extends Notifier<Map<String, Set<String>>> {
  @override
  Map<String, Set<String>> build() {
    final storage = ref.watch(localStorageServiceProvider);
    final map = <String, Set<String>>{};
    for (final chk in RulesDatabase.checklists) {
      map[chk.id] = storage.getCheckedItems(chk.id);
    }
    return map;
  }

  Future<void> toggleItem(String checklistId, String itemId) async {
    final storage = ref.read(localStorageServiceProvider);
    await storage.toggleChecklistItem(checklistId, itemId);
    final current = Map<String, Set<String>>.from(state);
    current[checklistId] = storage.getCheckedItems(checklistId);
    state = current;
  }

  Future<void> resetAll(String checklistId) async {
    final storage = ref.read(localStorageServiceProvider);
    await storage.resetChecklist(checklistId);
    final current = Map<String, Set<String>>.from(state);
    current[checklistId] = {};
    state = current;
  }
}

final checklistStateProvider =
    NotifierProvider<ChecklistStateNotifier, Map<String, Set<String>>>(
  ChecklistStateNotifier.new,
);
