import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/rule_category.dart';
import '../../core/models/sop_guide.dart';
import '../../core/providers/app_providers.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_icons.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_ui.dart';
import '../../l10n/app_localizations.dart';

/// Emergency procedures. Category filtering is local to this screen so it
/// never surprises the catalog tab with an unexpected filter.
class SopScreen extends ConsumerStatefulWidget {
  const SopScreen({super.key});

  @override
  ConsumerState<SopScreen> createState() => _SopScreenState();
}

class _SopScreenState extends ConsumerState<SopScreen> {
  RuleCategory _filter = RuleCategory.all;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = AppColors.of(context);
    final theme = Theme.of(context);
    final sops = ref.watch(allSopGuidesProvider);

    final filtered = sops
        .where((s) => _filter == RuleCategory.all || s.category == _filter)
        .toList();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppSpacing.lg,
        title: Text(l10n.sopEmergencyGuide, style: theme.textTheme.titleLarge),
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
                    l10n.sopBanner,
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
                return _SopFilterChip(
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
                    icon: AppIconData.shield,
                    title: l10n.noSopForCategory,
                    message: l10n.chooseAllCategoryForSop,
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
                    itemBuilder: (context, index) =>
                        _SopCard(sop: filtered[index]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _SopFilterChip extends StatelessWidget {
  final String label;
  final AppIconData icon;
  final bool selected;
  final Color selectedColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _SopFilterChip({
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

class _SopCard extends StatelessWidget {
  final SopGuide sop;

  const _SopCard({required this.sop});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = AppColors.of(context);
    final theme = Theme.of(context);
    final accent = sop.category.accent(c);

    return AppCard(
      onTap: () => context.push(AppRoutes.sopDetail(sop.id)),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.sm + 2),
                ),
                alignment: Alignment.center,
                child: AppIcon(
                  sop.category.icon,
                  size: 18,
                  color: accent,
                  strokeWidth: 1.9,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  sop.title,
                  style: theme.textTheme.titleSmall?.copyWith(height: 1.3),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            sop.targetScenario,
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
              Pill(
                label: sop.category.localizedShortLabel(l10n),
                tone: accent,
              ),
              const SizedBox(width: AppSpacing.sm),
              Pill(
                label: l10n.stepsCount(sop.steps.length),
                tone: c.textMuted,
              ),
              const Spacer(),
              AppIcon(AppIconData.chevronRight,
                  size: 16, color: c.textFaint),
            ],
          ),
        ],
      ),
    );
  }
}
