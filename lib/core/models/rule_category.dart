import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../../l10n/app_localizations.dart';

enum RuleCategory {
  all('Semua', 'Semua aturan dan panduan', Icons.grid_view, AppColors.primaryLight),
  traffic('Lalu Lintas', 'UU LLAJ, tilang, rambu, & batas kecepatan', Icons.traffic, AppColors.trafficTag),
  labor('Ketenagakerjaan', 'Jam kerja, lembur, hak cuti, & pesangon', Icons.work_outline, AppColors.laborTag),
  privacy('Privasi & ITE', 'UU PDP, perlindungan data, & transaksi digital', Icons.security, AppColors.privacyTag),
  consumer('Konsumen', 'Hak pembeli, garansi, & komplain barang cacat', Icons.shopping_bag_outlined, AppColors.consumerTag),
  safety('Keselamatan (K3)', 'SOP darurat, APD, & keselamatan tempat kerja', Icons.health_and_safety_outlined, AppColors.safetyTag),
  ethics('Etika & Ketertiban', 'Ketertiban umum, kebisingan, & norma publik', Icons.gavel_outlined, AppColors.ethicsTag);

  final String label;
  final String description;
  final IconData icon;
  final Color tagColor;

  const RuleCategory(this.label, this.description, this.icon, this.tagColor);

  String localizedLabel(AppLocalizations l10n) {
    switch (this) {
      case RuleCategory.all:
        return l10n.categoryAll;
      case RuleCategory.traffic:
        return l10n.catTraffic;
      case RuleCategory.labor:
        return l10n.catLabor;
      case RuleCategory.privacy:
        return l10n.catCyber;
      case RuleCategory.consumer:
        return l10n.catConsumer;
      case RuleCategory.safety:
        return l10n.catSafety;
      case RuleCategory.ethics:
        return l10n.catCivil;
    }
  }
}

