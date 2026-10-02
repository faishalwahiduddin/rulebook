import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/rule_category.dart';
import '../../core/models/rule_item.dart';
import '../../core/providers/app_providers.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_icons.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_ui.dart';
import '../../l10n/app_localizations.dart';
import '../catalog/widgets/rule_card.dart';

/// Saved rules and personal notes. Two modes share one list primitive so the
/// screen reads as one place, not two bolted-together tabs.
class BookmarksScreen extends ConsumerStatefulWidget {
  const BookmarksScreen({super.key});

  @override
  ConsumerState<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends ConsumerState<BookmarksScreen> {
  int _viewMode = 0; // 0 = saved rules, 1 = personal notes
  RuleCategory _filterCategory = RuleCategory.all;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = AppColors.of(context);
    final theme = Theme.of(context);
    final bookmarkedIds = ref.watch(bookmarksProvider);
    final allRules = ref.watch(allRulesProvider);
    final allNotes = ref.watch(ruleNotesProvider);

    bool passesFilter(RuleCategory cat) =>
        _filterCategory == RuleCategory.all || cat == _filterCategory;

    final savedRules = allRules
        .where((r) => bookmarkedIds.contains(r.id) && passesFilter(r.category))
        .toList();

    final notedRules = allRules
        .where((r) =>
            (allNotes[r.id] ?? '').isNotEmpty && passesFilter(r.category))
        .toList();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppSpacing.lg,
        title: Text(l10n.savedAndNotes, style: theme.textTheme.titleLarge),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, 0),
            child: _ModeSwitch(
              mode: _viewMode,
              savedCount: bookmarkedIds.length,
              notesCount: allNotes.length,
              onChanged: (m) => setState(() => _viewMode = m),
            ),
          ),
          if (_viewMode == 1) ...[
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 38,
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                scrollDirection: Axis.horizontal,
                itemCount: RuleCategory.values.length,
                separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final cat = RuleCategory.values[index];
                  final selected = _filterCategory == cat;
                  final accent = cat.accent(c);
                  return _FilterChip(
                    label: cat.localizedShortLabel(l10n),
                    icon: cat.icon,
                    selected: selected,
                    selectedColor: cat == RuleCategory.all ? c.brand : accent,
                    iconColor: selected ? c.onBrand : accent,
                    onTap: () => setState(() => _filterCategory = cat),
                  );
                },
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: _viewMode == 0
                ? _SavedRulesList(rules: savedRules)
                : _NotesList(rules: notedRules, notes: allNotes),
          ),
        ],
      ),
    );
  }
}

/// Segmented control for the two modes, drawn with the app's own tokens.
class _ModeSwitch extends StatelessWidget {
  final int mode;
  final int savedCount;
  final int notesCount;
  final ValueChanged<int> onChanged;

  const _ModeSwitch({
    required this.mode,
    required this.savedCount,
    required this.notesCount,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = AppColors.of(context);

    Widget segment(int index, String label, int count) {
      final selected = mode == index;
      return Expanded(
        child: GestureDetector(
          onTap: () => onChanged(index),
          child: AnimatedContainer(
            duration: AppMotion.fast,
            curve: AppMotion.ease,
            padding: const EdgeInsets.symmetric(vertical: 9),
            decoration: BoxDecoration(
              color: selected ? c.brand : Colors.transparent,
              borderRadius: BorderRadius.circular(AppRadius.sm + 2),
            ),
            alignment: Alignment.center,
            child: Text(
              '$label · $count',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? c.onBrand : c.textSecondary,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: c.surfaceSunken,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: c.border),
      ),
      child: Row(
        children: [
          segment(0, l10n.bookmarkTitle, savedCount),
          segment(1, l10n.myNotes, notesCount),
        ],
      ),
    );
  }
}

/// Category filter chip matching the catalog rail.
class _FilterChip extends StatelessWidget {
  final String label;
  final AppIconData icon;
  final bool selected;
  final Color selectedColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.selectedColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return Material(
      color: selected ? selectedColor : c.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm + 2),
        side: BorderSide(color: selected ? selectedColor : c.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(
                icon,
                size: 14,
                color: selected ? c.onBrand : iconColor,
                strokeWidth: 1.9,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected ? c.onBrand : c.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SavedRulesList extends ConsumerWidget {
  final List<RuleItem> rules;

  const _SavedRulesList({required this.rules});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    if (rules.isEmpty) {
      return AppEmptyState(
        icon: AppIconData.bookmark,
        title: l10n.noBookmarks,
        message: l10n.noBookmarksHint,
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg, AppSpacing.xs, AppSpacing.lg, AppSpacing.xxl),
      itemCount: rules.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final item = rules[index];
        return RuleCard(
          rule: item,
          onTap: () => context.push(AppRoutes.rule(item.id)),
        );
      },
    );
  }
}

// Typedef keeps the list widgets typed without a second model import.
class _NotesList extends ConsumerWidget {
  final List<RuleItem> rules;
  final Map<String, String> notes;

  const _NotesList({required this.rules, required this.notes});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    if (rules.isEmpty) {
      return AppEmptyState(
        icon: AppIconData.note,
        title: l10n.noNotes,
        message: l10n.noNotesHint,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg, AppSpacing.xs, AppSpacing.lg, AppSpacing.xxl),
      itemCount: rules.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final item = rules[index];
        return _NoteCard(
          rule: item,
          note: notes[item.id] ?? '',
        );
      },
    );
  }
}

class _NoteCard extends ConsumerWidget {
  final RuleItem rule;
  final String note;

  const _NoteCard({required this.rule, required this.note});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final c = AppColors.of(context);
    final theme = Theme.of(context);

    return AppCard(
      onTap: () => context.push(AppRoutes.rule(rule.id)),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppIcon(rule.category.icon, size: 16, color: rule.category.accent(c)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  rule.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: c.surfaceSunken,
              borderRadius: BorderRadius.circular(AppRadius.sm + 2),
            ),
            child: Text(
              note,
              style: theme.textTheme.bodySmall?.copyWith(
                color: c.textSecondary,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              const Spacer(),
              TextButton.icon(
                onPressed: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => _ConfirmDeleteNoteDialog(ruleTitle: rule.title),
                  );
                  if (confirmed == true) {
                    ref.read(ruleNotesProvider.notifier).deleteNote(rule.id);
                  }
                },
                style: TextButton.styleFrom(
                  foregroundColor: c.danger,
                  minimumSize: const Size(0, 36),
                  visualDensity: VisualDensity.compact,
                ),
                icon: AppIcon(AppIconData.trash, size: 15, color: c.danger),
                label: Text(l10n.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ConfirmDeleteNoteDialog extends StatelessWidget {
  final String ruleTitle;

  const _ConfirmDeleteNoteDialog({required this.ruleTitle});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.deleteNoteTitle),
      content: Text(l10n.deleteNoteDesc),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
          ),
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.delete),
        ),
      ],
    );
  }
}
