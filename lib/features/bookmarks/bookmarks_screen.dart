import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/models/rule_category.dart';
import '../../core/providers/app_providers.dart';
import '../../l10n/app_localizations.dart';
import '../catalog/rule_detail_screen.dart';

class BookmarksScreen extends ConsumerStatefulWidget {
  const BookmarksScreen({super.key});

  @override
  ConsumerState<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends ConsumerState<BookmarksScreen> {
  int _viewMode = 0; // 0 = Bookmark, 1 = Catatan Pribadi
  RuleCategory _filterCategory = RuleCategory.all;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bookmarkedIds = ref.watch(bookmarksProvider);
    final allRules = ref.watch(allRulesProvider);
    final allNotes = ref.watch(ruleNotesProvider);

    final bookmarkedRules = allRules.where((r) {
      if (!bookmarkedIds.contains(r.id)) return false;
      if (_filterCategory != RuleCategory.all && r.category != _filterCategory) return false;
      return true;
    }).toList();

    final notesRules = allRules.where((r) {
      if (!allNotes.containsKey(r.id) || allNotes[r.id]!.isEmpty) return false;
      if (_filterCategory != RuleCategory.all && r.category != _filterCategory) return false;
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.savedAndNotes),
      ),
      body: Column(
        children: [
          // Segment Mode Switcher
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.bgSurface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _viewMode = 0),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: _viewMode == 0 ? AppColors.primary : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${l10n.bookmarkTitle} (${bookmarkedIds.length})',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: _viewMode == 0 ? Colors.white : const Color(0xFF94A3B8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _viewMode = 1),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: _viewMode == 1 ? AppColors.primary : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${l10n.myNotes} (${allNotes.length})',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: _viewMode == 1 ? Colors.white : const Color(0xFF94A3B8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Category Filter
          SizedBox(
            height: 38,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: RuleCategory.values.length,
              separatorBuilder: (ctx, i) => const SizedBox(width: 6),
              itemBuilder: (context, index) {
                final cat = RuleCategory.values[index];
                final isSelected = _filterCategory == cat;
                return ChoiceChip(
                  label: Text(cat.localizedLabel(l10n), style: const TextStyle(fontSize: 11)),
                  selected: isSelected,
                  selectedColor: AppColors.primary,
                  onSelected: (_) => setState(() => _filterCategory = cat),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // Content
          Expanded(
            child: _viewMode == 0
                ? _buildBookmarksList(bookmarkedRules, l10n)
                : _buildNotesList(notesRules, allNotes, l10n),
          ),
        ],
      ),
    );
  }

  Widget _buildBookmarksList(List rules, AppLocalizations l10n) {
    if (rules.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.bookmark_border, size: 40, color: AppColors.accent),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.noBookmarks,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.noBookmarksHint,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: rules.length,
      itemBuilder: (context, index) {
        final item = rules[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(14),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: item.category.tagColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(item.category.icon, color: item.category.tagColor, size: 20),
              ),
              title: Text(
                item.title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    item.summary,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, color: Color(0xFFCBD5E1)),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.legalBasis,
                    style: const TextStyle(fontSize: 11, color: AppColors.accent, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.bookmark_remove, color: AppColors.danger, size: 20),
                tooltip: l10n.removeBookmark,
                onPressed: () {
                  ref.read(bookmarksProvider.notifier).toggleBookmark(item.id);
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RuleDetailScreen(rule: item)),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotesList(List rules, Map<String, String> allNotes, AppLocalizations l10n) {
    if (rules.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.note_alt_outlined, size: 40, color: AppColors.primaryLight),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.noNotes,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.noNotesHint,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: rules.length,
      itemBuilder: (context, index) {
        final item = rules[index];
        final noteText = allNotes[item.id] ?? '';
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Card(
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RuleDetailScreen(rule: item)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(item.category.icon, size: 16, color: item.category.tagColor),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            item.title,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.danger),
                          visualDensity: VisualDensity.compact,
                          onPressed: () {
                            ref.read(ruleNotesProvider.notifier).deleteNote(item.id);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.bgSurface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        noteText,
                        style: const TextStyle(fontSize: 12, color: Color(0xFFE2E8F0), height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
