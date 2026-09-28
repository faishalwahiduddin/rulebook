import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../core/models/sop_guide.dart';

class SopDetailScreen extends StatelessWidget {
  final SopGuide sop;

  const SopDetailScreen({super.key, required this.sop});

  void _copyToClipboard(BuildContext context, String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sop.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            tooltip: 'Salin Ringkasan SOP',
            onPressed: () {
              final buffer = StringBuffer();
              buffer.writeln('📋 ${sop.title}');
              buffer.writeln('Dasar Hukum: ${sop.legalBasis}');
              buffer.writeln('Situasi: ${sop.targetScenario}\n');
              buffer.writeln('--- LANGKAH TINDAKAN DARURAT ---');
              for (final s in sop.steps) {
                buffer.writeln('${s.stepNumber}. ${s.title}: ${s.detail}');
              }
              buffer.writeln('\nReferensi: RuleBook App (https://rulebook.faishal.id)');
              _copyToClipboard(context, buffer.toString(), 'Ringkasan SOP berhasil disalin!');
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
                // Header Badge & Scenario
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: sop.category.tagColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: sop.category.tagColor.withValues(alpha: 0.35)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(sop.category.icon, color: sop.category.tagColor, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            sop.category.label,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: sop.category.tagColor,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.emergency_outlined, size: 14, color: AppColors.danger),
                                SizedBox(width: 4),
                                Text(
                                  'SOP RESMI',
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.danger),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        sop.targetScenario,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white, height: 1.4),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Dasar Hukum: ${sop.legalBasis}',
                        style: const TextStyle(fontSize: 12, color: AppColors.accent, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Hak Penting Anda (Rights)
                const Row(
                  children: [
                    Icon(Icons.verified_user_outlined, color: AppColors.success, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Hak Hukum Wajib Anda Ketahui',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: sop.rightsSummary.map((right) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('✓ ', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.bold, fontSize: 14)),
                            Expanded(
                              child: Text(
                                right,
                                style: const TextStyle(fontSize: 13, color: Color(0xFFE2E8F0), height: 1.35),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 28),

                // Langkah Bertindak (Step by Step Timeline)
                const Row(
                  children: [
                    Icon(Icons.timeline, color: AppColors.primaryLight, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Langkah Demi Langkah Tindakan Darurat',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...sop.steps.map((step) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.bgSurface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${step.stepNumber}',
                                style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.white, fontSize: 13),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                step.title,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          step.detail,
                          style: const TextStyle(fontSize: 13, color: Color(0xFFCBD5E1), height: 1.45),
                        ),
                        if (step.warning != null) ...[
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.danger.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.danger.withValues(alpha: 0.3)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.warning_amber_rounded, color: AppColors.danger, size: 16),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    step.warning!,
                                    style: const TextStyle(fontSize: 12, color: Color(0xFFFCA5A5), height: 1.3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        if (step.practicalTip != null) ...[
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.3)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.lightbulb_outline, color: AppColors.accent, size: 16),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    step.practicalTip!,
                                    style: const TextStyle(fontSize: 12, color: Color(0xFFFDE68A), height: 1.3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 20),

                // Kontak Layanan / Hotline Darurat
                if (sop.emergencyContacts.isNotEmpty) ...[
                  const Row(
                    children: [
                      Icon(Icons.phone_in_talk, color: AppColors.accent, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Hotline & Kontak Resmi Terkait',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ...sop.emergencyContacts.map((contact) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: AppColors.bgSurface,
                          child: Icon(Icons.support_agent, color: AppColors.primaryLight),
                        ),
                        title: Text(
                          contact.name,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                        subtitle: Text(
                          contact.note,
                          style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.4)),
                          ),
                          child: Text(
                            contact.contactNumber,
                            style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primaryLight, fontSize: 13),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
