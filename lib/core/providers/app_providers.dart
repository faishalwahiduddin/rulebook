import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rule_category.dart';
import '../models/rule_item.dart';
import '../storage/local_storage_service.dart';
import '../storage/rules_database.dart';
import '../utils/validators.dart';

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  throw UnimplementedError('localStorageServiceProvider must be provided');
});

final allRulesProvider = Provider<List<RuleItem>>((ref) {
  return RulesDatabase.rules;
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
