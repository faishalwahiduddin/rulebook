import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/compliance_checklist.dart';
import '../../core/providers/app_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_icons.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_ui.dart';
import '../../l10n/app_localizations.dart';

/// One audit module: score header, items with legal basis, reset with
/// confirmation.
class ChecklistDetailScreen extends ConsumerWidget {
  final ComplianceChecklist checklist;

  const ChecklistDetailScreen({super.key, required this.checklist});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final c = AppColors.of(context);
    final theme = Theme.of(context);
    final checkedMap = ref.watch(checklistStateProvider);
    final checkedIds = checkedMap[checklist.id] ?? const <String>{};
    final totalItems = checklist.items.length;
    final checkedCount = checkedIds.length;
    final ratio = totalItems > 0 ? checkedCount / totalItems : 0.0;

    final (statusLabel, tone) = switch (ratio) {
      >= 1.0 => (l10n.perfectCompliance, c.success),
      >= 0.7 => (l10n.goodCompliance, c.success),
      >= 0.4 => (l10n.moderateCompliance, c.warning),
      _ => (l10n.criticalCompliance, c.danger),
    };

    return Scaffold(
      appBar: appBar(
        context,
        actions: [
          IconButton(
            tooltip: l10n.resetChecklist,
            icon: AppIcon(AppIconData.refresh, size: 20, color: c.textPrimary),
            onPressed: checkedCount == 0
                ? null
                : () => _confirmReset(context, ref),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.xxxl),
        children: [
          Pill(
            label: checklist.category.localizedLabel(l10n),
            icon: checklist.category.icon,
            tone: checklist.category.accent(c),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(checklist.title, style: theme.textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppIcon(AppIconData.info, size: 15, color: c.textMuted),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  '${checklist.targetAudience}. ${checklist.description}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: c.textSecondary,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),

          // Score summary. One glance: where you stand.
          AppCard(
            color: tone.withValues(alpha: 0.08),
            borderColor: tone.withValues(alpha: 0.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            statusLabel,
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: tone,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.itemsFulfilledCount(checkedCount, totalItems),
                            style: theme.textTheme.bodySmall
                                ?.copyWith(color: c.textMuted),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Text(
                      '${(ratio * 100).round()}%',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: tone,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                AppProgressBar(value: ratio, color: tone, height: 8),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          SectionHeader(title: l10n.checklistItems, icon: AppIconData.checklist),
          ...checklist.items.map((item) {
            final isChecked = checkedIds.contains(item.id);
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: AppCard(
                onTap: () => ref
                    .read(checklistStateProvider.notifier)
                    .toggleItem(checklist.id, item.id),
                color: isChecked ? c.successSoft : c.surface,
                borderColor:
                    isChecked ? c.success.withValues(alpha: 0.35) : c.border,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md, vertical: AppSpacing.md),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 22,
                      height: 22,
                      child: Checkbox(
                        value: isChecked,
                        onChanged: (_) => ref
                            .read(checklistStateProvider.notifier)
                            .toggleItem(checklist.id, item.id),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  item.title,
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    color: isChecked
                                        ? c.textSecondary
                                        : c.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (item.isCrucial) ...[
                                const SizedBox(width: AppSpacing.sm),
                                Pill(label: l10n.crucial, tone: c.danger),
                              ],
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.description,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: c.textSecondary,
                              height: 1.45,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item.legalBasis,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: c.textMuted,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Future<void> _confirmReset(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.resetChecklistTitle),
        content: Text(l10n.resetChecklistConfirmMsg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.reset),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref
          .read(checklistStateProvider.notifier)
          .resetAll(checklist.id);
    }
  }
}
