import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/rule_category.dart';
import '../../core/providers/app_providers.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_icons.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_ui.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/read_badge.dart';
import 'widgets/rule_card.dart';

class CatalogScreen extends ConsumerStatefulWidget {
  const CatalogScreen({super.key});

  @override
  ConsumerState<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends ConsumerState<CatalogScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: ref.read(searchQueryProvider));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _setQuery(String value) {
    _searchController.text = value;
    _searchController.selection =
        TextSelection.collapsed(offset: value.length);
    ref.read(searchQueryProvider.notifier).setQuery(value);
    setState(() {});
  }

  void _clearAll() {
    _searchController.clear();
    ref.read(searchQueryProvider.notifier).clear();
    ref.read(selectedCategoryProvider.notifier).selectCategory(RuleCategory.all);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = AppColors.of(context);
    final theme = Theme.of(context);
    final rules = ref.watch(filteredRulesProvider);
    final activeCategory = ref.watch(selectedCategoryProvider);
    final query = ref.watch(searchQueryProvider);
    final hasFilter =
        query.trim().isNotEmpty || activeCategory != RuleCategory.all;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppSpacing.lg,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: c.brand,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              alignment: Alignment.center,
              child: AppIcon(AppIconData.scale, size: 19, color: c.onBrand),
            ),
            const SizedBox(width: AppSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.appName,
                  style: theme.textTheme.titleLarge?.copyWith(height: 1.1),
                ),
                Text(
                  l10n.appDescription,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: c.textMuted,
                    letterSpacing: 0.1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: l10n.settingsAndPrivacy,
            icon: AppIcon(AppIconData.settings, size: 22, color: c.textPrimary),
            onPressed: () => context.push(AppRoutes.settings),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, 0),
            child: Column(
              children: [
                _SearchField(
                  controller: _searchController,
                  onChanged: (v) {
                    ref.read(searchQueryProvider.notifier).setQuery(v);
                    setState(() {});
                  },
                  onClear: () => _setQuery(''),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            ),
          ),
          _QuickChips(
            activeQuery: query,
            onSelect: _setQuery,
          ),
          const SizedBox(height: AppSpacing.md),
          // Gamifikasi: badge aturan dibaca.
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: ReadBadge(total: rules.length),
          ),
          const SizedBox(height: AppSpacing.md),
          _CategoryRail(
            active: activeCategory,
            onSelect: (cat) {
              ref.read(selectedCategoryProvider.notifier).selectCategory(cat);
            },
          ),
          const SizedBox(height: AppSpacing.md),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              children: [
                Text(
                  l10n.resultsCount(rules.length),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: c.textMuted,
                  ),
                ),
                const Spacer(),
                if (hasFilter)
                  TextButton.icon(
                    onPressed: _clearAll,
                    style: TextButton.styleFrom(
                      minimumSize: const Size(0, 32),
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                      visualDensity: VisualDensity.compact,
                    ),
                    icon: AppIcon(AppIconData.close, size: 14, color: c.brand),
                    label: Text(l10n.resetFilters),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Expanded(
            child: rules.isEmpty
                ? AppEmptyState(
                    icon: AppIconData.search,
                    title: l10n.noRulesMatch,
                    message: l10n.tryOtherKeywords,
                    actionLabel: hasFilter ? l10n.resetFilters : null,
                    onAction: hasFilter ? _clearAll : null,
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                        AppSpacing.lg, AppSpacing.xs, AppSpacing.lg, AppSpacing.xxl),
                    itemCount: rules.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final item = rules[index];
                      return RuleCard(
                        rule: item,
                        onTap: () => context.push(AppRoutes.rule(item.id)),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const _SearchField({
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Semantics(
      textField: true,
      label: l10n.searchAriaLabel,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: c.textPrimary,
              fontSize: 14.5,
            ),
        decoration: InputDecoration(
          hintText: l10n.searchRulesHint,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 4, right: 2),
            child: AppIcon(AppIconData.search, size: 19, color: c.textMuted),
          ),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 44, minHeight: 44),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  tooltip: l10n.clearSearch,
                  icon: AppIcon(AppIconData.close, size: 16, color: c.textMuted),
                  onPressed: onClear,
                ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

class _QuickChips extends StatelessWidget {
  final String activeQuery;
  final ValueChanged<String> onSelect;

  const _QuickChips({required this.activeQuery, required this.onSelect});

  static const _keywords = [
    'Tilang',
    'Lembur',
    'Pesangon',
    'UU PDP',
    'K3',
    'Garansi',
    'Busway',
    'Knalpot',
  ];

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return SizedBox(
      height: 34,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        scrollDirection: Axis.horizontal,
        itemCount: _keywords.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final kw = _keywords[index];
          final selected = activeQuery.toLowerCase() == kw.toLowerCase();
          return _SoftChip(
            label: kw,
            selected: selected,
            onTap: () => onSelect(selected ? '' : kw),
            selectedColor: c.brand,
          );
        },
      ),
    );
  }
}

class _CategoryRail extends StatelessWidget {
  final RuleCategory active;
  final ValueChanged<RuleCategory> onSelect;

  const _CategoryRail({required this.active, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      height: 38,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        scrollDirection: Axis.horizontal,
        itemCount: RuleCategory.values.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final cat = RuleCategory.values[index];
          final selected = active == cat;
          final accent = cat.accent(c);
          return _SoftChip(
            label: cat.localizedShortLabel(l10n),
            icon: cat.icon,
            iconColor: selected ? c.onBrand : accent,
            selected: selected,
            onTap: () => onSelect(cat),
            selectedColor: cat == RuleCategory.all ? c.brand : accent,
          );
        },
      ),
    );
  }
}

/// One chip primitive for both quick keywords and categories.
class _SoftChip extends StatelessWidget {
  final String label;
  final AppIconData? icon;
  final Color? iconColor;
  final bool selected;
  final VoidCallback onTap;
  final Color selectedColor;

  const _SoftChip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.selectedColor,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return Material(
      color: selected ? selectedColor : c.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm + 2),
        side: BorderSide(
          color: selected ? selectedColor : c.border,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                AppIcon(
                  icon!,
                  size: 14,
                  color: iconColor ?? (selected ? c.onBrand : c.textMuted),
                  strokeWidth: 1.9,
                ),
                const SizedBox(width: 6),
              ],
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
