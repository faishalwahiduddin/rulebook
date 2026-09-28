import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/models/rule_category.dart';
import '../../core/providers/app_providers.dart';
import 'checklist_detail_screen.dart';

class ChecklistScreen extends ConsumerWidget {
  const ChecklistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checklists = ref.watch(allChecklistsProvider);
    final activeCategory = ref.watch(selectedCategoryProvider);

    final filtered = checklists.where((c) {
      if (activeCategory == RuleCategory.all) return true;
      return c.category == activeCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.fact_check_outlined, color: AppColors.primaryLight, size: 22),
            SizedBox(width: 10),
            Text('Audit Kepatuhan Mandiri', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
          ],
        ),
      ),
      body: Column(
        children: [
          // Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppColors.bgSurface,
            child: const Text(
              'Alat audit kepatuhan interaktif untuk mengecek kelayakan kendaraan, hak kerja normatif, standar K3 gedung, dan keamanan privasi data.',
              style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8), height: 1.35),
            ),
          ),

          // Categories Chips
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
                  label: Text(cat.label),
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

          // Checklists List
          Expanded(
            child: filtered.isEmpty
                ? const Center(
                    child: Text('Tidak ada modul audit untuk kategori ini.', style: TextStyle(color: Color(0xFF94A3B8))),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      final checkedMap = ref.watch(checklistStateProvider);
                      final checkedIds = checkedMap[item.id] ?? <String>{};
                      final total = item.items.length;
                      final checked = checkedIds.length;
                      final ratio = total > 0 ? (checked / total) : 0.0;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Card(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ChecklistDetailScreen(checklist: item),
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
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: item.category.tagColor.withValues(alpha: 0.15),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Icon(item.category.icon, color: item.category.tagColor, size: 20),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.title,
                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              item.targetAudience,
                                              style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '${(ratio * 100).toInt()}%',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                          color: ratio == 1.0 ? AppColors.success : AppColors.primaryLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: ratio,
                                      minHeight: 6,
                                      backgroundColor: const Color(0xFF1E293B),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        ratio == 1.0 ? AppColors.success : AppColors.primaryLight,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '$checked dari $total butir terpenuhi',
                                        style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                                      ),
                                      const Row(
                                        children: [
                                          Text(
                                            'Mulai Audit',
                                            style: TextStyle(fontSize: 12, color: AppColors.primaryLight, fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(width: 4),
                                          Icon(Icons.arrow_forward_ios, size: 10, color: AppColors.primaryLight),
                                        ],
                                      ),
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
