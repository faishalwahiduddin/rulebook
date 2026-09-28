import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/models/rule_category.dart';
import '../../core/providers/app_providers.dart';
import '../../l10n/app_localizations.dart';
import 'sop_detail_screen.dart';

class SopScreen extends ConsumerWidget {
  const SopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final sops = ref.watch(filteredSopGuidesProvider);
    final activeCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.shield_outlined, color: AppColors.accent, size: 22),
            const SizedBox(width: 10),
            Text(l10n.sopEmergencyGuide, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
          ],
        ),
      ),
      body: Column(
        children: [
          // Banner Info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppColors.bgSurface,
            child: Text(
              l10n.sopBanner,
              style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8), height: 1.35),
            ),
          ),

          // Categories Horizontal Chips
          SizedBox(
            height: 48,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              scrollDirection: Axis.horizontal,
              itemCount: RuleCategory.values.length,
              separatorBuilder: (ctx, i) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = RuleCategory.values[index];
                final isSelected = activeCategory == cat;
                return ChoiceChip(
                  avatar: Icon(cat.icon, size: 15, color: isSelected ? Colors.white : cat.tagColor),
                  label: Text(cat.localizedLabel(l10n)),
                  selected: isSelected,
                  selectedColor: AppColors.primary,
                  onSelected: (_) {
                    ref.read(selectedCategoryProvider.notifier).selectCategory(cat);
                  },
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                    color: isSelected ? Colors.white : const Color(0xFFCBD5E1),
                  ),
                );
              },
            ),
          ),

          // SOP List
          Expanded(
            child: sops.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.rule_folder_outlined, size: 48, color: Color(0xFF64748B)),
                          const SizedBox(height: 12),
                          Text(
                            l10n.noSopForCategory,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            l10n.chooseAllCategoryForSop,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: sops.length,
                    itemBuilder: (context, index) {
                      final item = sops[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Card(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SopDetailScreen(sop: item),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: item.category.tagColor.withValues(alpha: 0.15),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          item.category.localizedLabel(l10n),
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color: item.category.tagColor,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary.withValues(alpha: 0.2),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          l10n.stepsCount(item.steps.length),
                                          style: const TextStyle(fontSize: 10, color: AppColors.primaryLight, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    item.title,
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    item.targetScenario,
                                    style: const TextStyle(fontSize: 12, color: Color(0xFFCBD5E1), height: 1.35),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(Icons.gavel, size: 14, color: AppColors.accent),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          item.legalBasis,
                                          style: const TextStyle(fontSize: 11, color: AppColors.accent, fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Icon(Icons.arrow_forward_ios, size: 12, color: Color(0xFF94A3B8)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
