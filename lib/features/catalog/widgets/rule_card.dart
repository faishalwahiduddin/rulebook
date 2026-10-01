import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/rule_item.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_ui.dart';
import '../../../l10n/app_localizations.dart';

/// Compact, scannable rule entry: category, title, one-line summary, and the
/// consequence. Bookmark toggle lives on the card so saving is one tap.
class RuleCard extends ConsumerWidget {
  final RuleItem rule;
  final VoidCallback onTap;
  final bool showCategory;

  const RuleCard({
    super.key,
    required this.rule,
    required this.onTap,
    this.showCategory = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = AppColors.of(context);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final saved = ref.watch(bookmarksProvider).contains(rule.id);
    final accent = rule.category.accent(c);

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.sm, AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.sm + 2),
            ),
            alignment: Alignment.center,
            child: AppIcon(rule.category.icon, size: 19, color: accent, strokeWidth: 1.9),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showCategory) ...[
                  Text(
                    rule.category.localizedLabel(l10n).toUpperCase(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: accent,
                      letterSpacing: 0.7,
                    ),
                  ),
                  const SizedBox(height: 3),
                ],
                Text(
                  rule.title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: c.textPrimary,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs + 2),
                Text(
                  rule.summary,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: c.textSecondary,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    AppIcon(AppIconData.scale, size: 14, color: c.textMuted),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        rule.penaltyOrRight,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: c.textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          IconButton(
            visualDensity: VisualDensity.compact,
            tooltip: saved ? l10n.removeBookmark : l10n.saveRule,
            icon: AppIcon(
              saved ? AppIconData.bookmarkFilled : AppIconData.bookmark,
              size: 20,
              color: saved ? c.brand : c.textFaint,
            ),
            onPressed: () => ref.read(bookmarksProvider.notifier).toggleBookmark(rule.id),
          ),
        ],
      ),
    );
  }
}
