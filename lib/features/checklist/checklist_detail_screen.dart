import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/models/compliance_checklist.dart';
import '../../core/providers/app_providers.dart';

class ChecklistDetailScreen extends ConsumerWidget {
  final ComplianceChecklist checklist;

  const ChecklistDetailScreen({super.key, required this.checklist});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkedMap = ref.watch(checklistStateProvider);
    final checkedIds = checkedMap[checklist.id] ?? <String>{};
    final totalItems = checklist.items.length;
    final checkedCount = checkedIds.length;
    final percentage = totalItems > 0 ? (checkedCount / totalItems) : 0.0;

    Color progressColor;
    String scoreStatus;
    if (percentage == 1.0) {
      progressColor = AppColors.success;
      scoreStatus = 'Kepatuhan Sempurna (100%)';
    } else if (percentage >= 0.7) {
      progressColor = AppColors.primaryLight;
      scoreStatus = 'Kepatuhan Baik';
    } else if (percentage >= 0.4) {
      progressColor = AppColors.accent;
      scoreStatus = 'Kepatuhan Sedang — Butuh Perhatian';
    } else {
      progressColor = AppColors.danger;
      scoreStatus = 'Tingkat Kepatuhan Kritis';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(checklist.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset Checklist',
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: AppColors.bgSurface,
                  title: const Text('Reset Checklist?', style: TextStyle(color: Colors.white)),
                  content: const Text(
                    'Tindakan ini akan mengosongkan semua tanda centang pada modul audit ini.',
                    style: TextStyle(color: Color(0xFF94A3B8)),
                  ),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger),
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await ref.read(checklistStateProvider.notifier).resetAll(checklist.id);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Score Gauge Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.bgSurface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: progressColor.withValues(alpha: 0.5), width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                scoreStatus,
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: progressColor),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$checkedCount dari $totalItems butir audit terpenuhi',
                                style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                              ),
                            ],
                          ),
                          Text(
                            '${(percentage * 100).toInt()}%',
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: progressColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: percentage,
                          minHeight: 10,
                          backgroundColor: const Color(0xFF1E293B),
                          valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Audience & Description
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: checklist.category.tagColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: checklist.category.tagColor, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Sasaran: ${checklist.targetAudience} • ${checklist.description}',
                          style: const TextStyle(fontSize: 12, color: Color(0xFFE2E8F0)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Items Checklist
                const Text(
                  'Daftar Butir Pemeriksaan',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                ),
                const SizedBox(height: 10),
                ...checklist.items.map((item) {
                  final isChecked = checkedIds.contains(item.id);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: isChecked ? AppColors.success.withValues(alpha: 0.08) : AppColors.bgCard,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isChecked ? AppColors.success.withValues(alpha: 0.4) : AppColors.border,
                      ),
                    ),
                    child: CheckboxListTile(
                      value: isChecked,
                      activeColor: AppColors.success,
                      checkColor: Colors.white,
                      onChanged: (_) {
                        ref.read(checklistStateProvider.notifier).toggleItem(checklist.id, item.id);
                      },
                      contentPadding: const EdgeInsets.all(12),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: isChecked ? Colors.white : const Color(0xFFE2E8F0),
                                decoration: isChecked ? TextDecoration.lineThrough : null,
                              ),
                            ),
                          ),
                          if (item.isCrucial)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.danger.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'KRUSIAL',
                                style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.danger),
                              ),
                            ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            item.description,
                            style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8), height: 1.35),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item.legalBasis,
                            style: const TextStyle(fontSize: 11, color: AppColors.accent, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
