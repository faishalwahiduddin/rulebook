import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/compliance_checklist.dart';
import '../../core/models/rule_category.dart';
import '../../core/providers/app_providers.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_icons.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_ui.dart';
import '../../l10n/app_localizations.dart';

/// Self-audit modules. Local filter, live progress per module.
class ChecklistScreen extends ConsumerStatefulWidget {
  const ChecklistScreen({super.key});

  @override
  ConsumerState<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends ConsumerState<ChecklistScreen> {
  RuleCategory _filter = RuleCategory.all;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = AppColors.of(context);
    final theme = Theme.of(context);
    final checklists = ref.watch(allChecklistsProvider);
    final checkedMap = ref.watch(checklistStateProvider);

    final filtered = checklists
        .where((chk) => _filter == RuleCategory.all || chk.category == _filter)
        .toList();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppSpacing.lg,
        title: Text(l10n.checklistTitle, style: theme.textTheme.titleLarge),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppIcon(AppIconData.info, size: 16, color: c.textMuted),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.checklistBanner,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: c.textSecondary,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                final selected = _filter == cat;
                final accent = cat.accent(c);
                return _ChecklistFilterChip(
                  label: cat.localizedShortLabel(l10n),
                  icon: cat.icon,
                  selected: selected,
                  selectedColor:
                      cat == RuleCategory.all ? c.brand : accent,
                  iconColor: selected ? c.onBrand : accent,
                  onTap: () => setState(() => _filter = cat),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: filtered.isEmpty
                ? AppEmptyState(
                    icon: AppIconData.checklist,
                    title: l10n.noAuditModulesTitle,
                    message: l10n.noAuditModulesHint,
                    actionLabel: l10n.categoryAll,
                    onAction: () =>
                        setState(() => _filter = RuleCategory.all),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(AppSpacing.lg,
                        AppSpacing.xs, AppSpacing.lg, AppSpacing.xxl),
                    itemCount: filtered.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      return _ChecklistCard(
                        checklist: item,
                        checkedCount:
                            (checkedMap[item.id] ?? const <String>{}).length,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _ChecklistFilterChip extends StatelessWidget {
  final String label;
  final AppIconData icon;
  final bool selected;
  final Color selectedColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _ChecklistFilterChip({
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

class _ChecklistCard extends ConsumerWidget {
  final ComplianceChecklist checklist;
  final int checkedCount;

  const _ChecklistCard({
    required this.checklist,
    required this.checkedCount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final c = AppColors.of(context);
    final theme = Theme.of(context);
    final accent = checklist.category.accent(c);
    final total = checklist.items.length;
    final ratio = total > 0 ? checkedCount / total : 0.0;
    final done = ratio >= 1.0;

    return AppCard(
      onTap: () => context.push(AppRoutes.checklistDetail(checklist.id)),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.sm + 2),
                ),
                alignment: Alignment.center,
                child: AppIcon(
                  checklist.category.icon,
                  size: 19,
                  color: accent,
                  strokeWidth: 1.9,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      checklist.title,
                      style: theme.textTheme.titleSmall
                          ?.copyWith(height: 1.3),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      checklist.targetAudience,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: c.textMuted),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                '${(ratio * 100).round()}%',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: done ? c.success : c.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AppProgressBar(
            value: ratio,
            color: done ? c.success : c.brand,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Text(
                l10n.itemsFulfilledCount(checkedCount, total),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: c.textMuted,
                ),
              ),
              const Spacer(),
              Text(
                l10n.startAudit,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: c.brand,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 4),
              AppIcon(AppIconData.chevronRight, size: 14, color: c.brand),
            ],
          ),
        ],
      ),
    );
  }
}
