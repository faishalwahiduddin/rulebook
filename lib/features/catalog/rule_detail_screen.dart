import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/rule_item.dart';
import '../../core/providers/app_providers.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_icons.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_ui.dart';
import '../../l10n/app_localizations.dart';

class RuleDetailScreen extends ConsumerStatefulWidget {
  final RuleItem rule;

  const RuleDetailScreen({super.key, required this.rule});

  @override
  ConsumerState<RuleDetailScreen> createState() => _RuleDetailScreenState();
}

class _RuleDetailScreenState extends ConsumerState<RuleDetailScreen> {
  late final TextEditingController _noteController;
  String? _noteError;
  bool _isSavingNote = false;

  @override
  void initState() {
    super.initState();
    final saved = ref.read(localStorageServiceProvider).getNote(widget.rule.id) ?? '';
    _noteController = TextEditingController(text: saved);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  RuleItem get _rule => widget.rule;

  void _toast(String message, {bool success = false}) {
    final c = AppColors.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: success ? c.success : null,
        ),
      );
  }

  void _copySummary() {
    final l10n = AppLocalizations.of(context)!;
    final text = '${_rule.title}\n'
        '${l10n.legalBasisLabel}: ${_rule.legalBasis}\n'
        '${l10n.summary}: ${_rule.summary}\n'
        '${l10n.consequenceLabel}: ${_rule.penaltyOrRight}\n\n'
        '${l10n.appName} · rulebook.faishal.id';
    Clipboard.setData(ClipboardData(text: text));
    _toast(l10n.summaryCopied, success: true);
  }

  Future<void> _saveNote() async {
    final l10n = AppLocalizations.of(context)!;
    final text = _noteController.text.trim();
    final notifier = ref.read(ruleNotesProvider.notifier);

    if (text.isEmpty) {
      await notifier.deleteNote(_rule.id);
      if (mounted) {
        setState(() => _noteError = null);
        _toast(l10n.noteDeleted);
      }
      return;
    }

    final err = AppValidators.validateNoteText(text);
    if (err != null) {
      setState(() => _noteError = err);
      return;
    }

    setState(() => _isSavingNote = true);
    try {
      await notifier.saveNote(_rule.id, text);
      if (mounted) {
        setState(() => _noteError = null);
        _toast(l10n.noteSaved, success: true);
        FocusScope.of(context).unfocus();
      }
    } finally {
      if (mounted) setState(() => _isSavingNote = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = AppColors.of(context);
    final theme = Theme.of(context);
    final saved = ref.watch(bookmarksProvider).contains(_rule.id);
    final accent = _rule.category.accent(c);
    final related = ref
        .watch(allRulesProvider)
        .where((r) => r.category == _rule.category && r.id != _rule.id)
        .take(3)
        .toList();

    return Scaffold(
      appBar: appBar(
        context,
        actions: [
          IconButton(
            tooltip: l10n.copySummary,
            icon: AppIcon(AppIconData.copy, size: 20, color: c.textPrimary),
            onPressed: _copySummary,
          ),
          IconButton(
            tooltip: saved ? l10n.removeBookmark : l10n.saveRule,
            icon: AppIcon(
              saved ? AppIconData.bookmarkFilled : AppIconData.bookmark,
              size: 21,
              color: saved ? c.brand : c.textPrimary,
            ),
            onPressed: () =>
                ref.read(bookmarksProvider.notifier).toggleBookmark(_rule.id),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.xxxl),
        children: [
          Pill(
            label: _rule.category.localizedLabel(l10n),
            icon: _rule.category.icon,
            tone: accent,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            _rule.title,
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppIcon(AppIconData.book, size: 15, color: c.textMuted),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  _rule.legalBasis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: c.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),

          // The single most important line: what happens.
          AppCard(
            color: c.dangerSoft,
            borderColor: c.danger.withValues(alpha: 0.35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppIcon(AppIconData.scale, size: 20, color: c.danger),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.consequenceLabel.toUpperCase(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: c.danger,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _rule.penaltyOrRight,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: c.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          SectionHeader(
            title: l10n.whatItMeans,
            icon: AppIconData.info,
          ),
          Text(
            _rule.fullExplanation,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: c.textSecondary,
              height: 1.65,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          SectionHeader(title: l10n.doThis, icon: AppIconData.checkCircle),
          ..._rule.keyDos.map((item) => _GuidanceRow(
                text: item,
                tone: c.success,
                icon: AppIconData.check,
              )),
          const SizedBox(height: AppSpacing.lg),
          SectionHeader(title: l10n.avoidThis, icon: AppIconData.closeCircle),
          ..._rule.keyDonts.map((item) => _GuidanceRow(
                text: item,
                tone: c.danger,
                icon: AppIconData.close,
              )),
          const SizedBox(height: AppSpacing.xxl),

          SectionHeader(title: l10n.personalNote, icon: AppIconData.note),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _noteController,
                  maxLines: 4,
                  minLines: 3,
                  maxLength: 500,
                  onChanged: (val) {
                    if (_noteError != null) {
                      setState(() => _noteError = AppValidators.validateNoteText(val));
                    } else {
                      setState(() {});
                    }
                  },
                  decoration: InputDecoration(
                    hintText: l10n.noteEmptyHint,
                    errorText: _noteError,
                    counterText: '',
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Text(
                      l10n.noteLengthCounter(
                        _noteController.text.trim().length,
                        500,
                      ),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: c.textFaint,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    if (_noteController.text.trim().isNotEmpty)
                      TextButton(
                        onPressed: _isSavingNote
                            ? null
                            : () {
                                _noteController.clear();
                                _saveNote();
                              },
                        style: TextButton.styleFrom(
                          foregroundColor: c.textMuted,
                          minimumSize: const Size(0, 40),
                        ),
                        child: Text(l10n.clearNote),
                      ),
                    const SizedBox(width: AppSpacing.sm),
                    FilledButton(
                      onPressed: _isSavingNote ? null : _saveNote,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 42),
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg),
                      ),
                      child: _isSavingNote
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(l10n.saveNote),
                    ),
                  ],
                ),
              ],
            ),
          ),

          if (related.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xxl),
            SectionHeader(title: l10n.relatedRules, icon: AppIconData.layers),
            ...related.map(
              (rel) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: AppCard(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  onTap: () => context.pushReplacement(AppRoutes.rule(rel.id)),
                  child: Row(
                    children: [
                      AppIcon(rel.category.icon,
                          size: 18, color: rel.category.accent(c)),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          rel.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                      AppIcon(AppIconData.chevronRight,
                          size: 16, color: c.textFaint),
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

class _GuidanceRow extends StatelessWidget {
  final String text;
  final Color tone;
  final AppIconData icon;

  const _GuidanceRow({required this.text, required this.tone, required this.icon});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: AppIcon(icon, size: 12, color: tone, strokeWidth: 2.2),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: c.textSecondary,
                    height: 1.55,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
