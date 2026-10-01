import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/models/sop_guide.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_icons.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_ui.dart';
import '../../l10n/app_localizations.dart';

/// Step-by-step emergency procedure with rights, warnings, and hotlines.
class SopDetailScreen extends StatelessWidget {
  final SopGuide sop;

  const SopDetailScreen({super.key, required this.sop});

  void _copySummary(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final buffer = StringBuffer()
      ..writeln(sop.title)
      ..writeln('${l10n.legalBasisLabel}: ${sop.legalBasis}')
      ..writeln('${l10n.situation}: ${sop.targetScenario}')
      ..writeln()
      ..writeln(l10n.emergencySteps);
    for (final s in sop.steps) {
      buffer.writeln('${s.stepNumber}. ${s.title}: ${s.detail}');
    }
    buffer
      ..writeln()
      ..writeln('RuleBook · rulebook.faishal.id');
    Clipboard.setData(ClipboardData(text: buffer.toString()));
    final c = AppColors.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(l10n.sopSummaryCopied),
          backgroundColor: c.success,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = AppColors.of(context);
    final theme = Theme.of(context);
    final accent = sop.category.accent(c);

    return Scaffold(
      appBar: appBar(
        context,
        actions: [
          IconButton(
            tooltip: l10n.copySopSummary,
            icon: AppIcon(AppIconData.copy, size: 20, color: c.textPrimary),
            onPressed: () => _copySummary(context),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.xxxl),
        children: [
          Pill(
            label: sop.category.localizedLabel(l10n),
            icon: sop.category.icon,
            tone: accent,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(sop.title, style: theme.textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppIcon(AppIconData.book, size: 15, color: c.textMuted),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  sop.legalBasis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: c.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),

          // The scenario, stated plainly so people can match it to reality.
          AppCard(
            color: c.brandSoft.withValues(alpha: 0.35),
            borderColor: accent.withValues(alpha: 0.25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppIcon(AppIconData.info, size: 18, color: accent),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    sop.targetScenario,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: c.textPrimary,
                      height: 1.55,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          if (sop.rightsSummary.isNotEmpty) ...[
            SectionHeader(title: l10n.rights, icon: AppIconData.checkCircle),
            ...sop.rightsSummary.map(
              (right) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.only(top: 1),
                      decoration: BoxDecoration(
                        color: c.success.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: AppIcon(AppIconData.check,
                          size: 12, color: c.success, strokeWidth: 2.2),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        right,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: c.textSecondary,
                          height: 1.55,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],

          SectionHeader(title: l10n.emergencySteps, icon: AppIconData.clock),
          ...sop.steps.map((step) => _StepCard(step: step)),
          const SizedBox(height: AppSpacing.xxl),

          if (sop.emergencyContacts.isNotEmpty) ...[
            SectionHeader(title: l10n.hotlineContacts, icon: AppIconData.phone),
            ...sop.emergencyContacts.map(
              (contact) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: AppCard(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: c.brandSoft,
                          borderRadius:
                              BorderRadius.circular(AppRadius.sm + 2),
                        ),
                        alignment: Alignment.center,
                        child: AppIcon(AppIconData.phone,
                            size: 17, color: c.onBrandSoft),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              contact.name,
                              style: theme.textTheme.titleSmall,
                            ),
                            if (contact.note.isNotEmpty) ...[
                              const SizedBox(height: 2),
                              Text(
                                contact.note,
                                style: theme.textTheme.bodySmall
                                    ?.copyWith(color: c.textMuted),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        contact.contactNumber,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: c.brand,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final SopStep step;

  const _StepCard({required this.step});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppCard(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: c.brand,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${step.stepNumber}',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: c.onBrand,
                      fontSize: 12.5,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(step.title, style: theme.textTheme.titleSmall),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              step.detail,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: c.textSecondary,
                height: 1.6,
              ),
            ),
            if (step.warning != null) ...[
              const SizedBox(height: AppSpacing.md),
              _Callout(
                icon: AppIconData.warning,
                tone: c.danger,
                text: step.warning!,
              ),
            ],
            if (step.practicalTip != null) ...[
              const SizedBox(height: AppSpacing.sm),
              _Callout(
                icon: AppIconData.bulb,
                tone: c.warning,
                text: step.practicalTip!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Quiet inline callout for warnings and tips; tint lives in the text, not a
/// loud block of color.
class _Callout extends StatelessWidget {
  final AppIconData icon;
  final Color tone;
  final String text;

  const _Callout({required this.icon, required this.tone, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppIcon(icon, size: 15, color: tone),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: tone,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
