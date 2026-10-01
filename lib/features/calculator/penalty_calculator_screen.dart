import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../core/models/cyber_penalty_models.dart';
import '../../core/models/severance_calculator_models.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_icons.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_ui.dart';
import '../../l10n/app_localizations.dart';

/// Five quick estimators: overtime, severance, THR, traffic fines, and the
/// ITE/cyber penalty table. Everything recalculates as you type.
class PenaltyCalculatorScreen extends StatefulWidget {
  const PenaltyCalculatorScreen({super.key});

  @override
  State<PenaltyCalculatorScreen> createState() =>
      _PenaltyCalculatorScreenState();
}

class _PenaltyCalculatorScreenState extends State<PenaltyCalculatorScreen> {
  int _selectedTab = 0;

  final NumberFormat _rupiah = NumberFormat.currency(
      locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  // --- Overtime ---
  final _overtimeSalaryController = TextEditingController(text: '5000000');
  final _overtimeHoursController = TextEditingController(text: '3');
  bool _isHoliday = false;
  double _overtimePay = 0;
  String? _overtimeError;

  // --- Severance ---
  final _severanceSalaryController = TextEditingController(text: '6500000');
  final _severanceYearsController = TextEditingController(text: '3');
  final _severanceMonthsController = TextEditingController(text: '6');
  final _severanceUphController = TextEditingController(text: '0');
  PhkReason _phkReason = SeveranceCalculatorEngine.reasons[0];
  SeveranceResult? _severanceResult;
  String? _severanceError;

  // --- THR ---
  final _thrSalaryController = TextEditingController(text: '5000000');
  final _thrMonthsController = TextEditingController(text: '8');
  double _thrPay = 0;
  String? _thrError;

  // --- Traffic fines ---
  static const Map<String, int> _violations = {
    'Tidak Memiliki SIM yang Sah (Pasal 281)': 1000000,
    'Tidak Membawa STNK Sah (Pasal 288 ayat 1)': 500000,
    'Mengoperasikan HP Saat Mengemudi (Pasal 283)': 750000,
    'Melebihi Batas Kecepatan Maksimal (Pasal 287 ayat 5)': 500000,
    'Tidak Menyalakan Lampu Utama Motor Siang Hari (Pasal 293)': 100000,
    'Melanggar Rambu Lalu Lintas / Lampu Merah (Pasal 287 ayat 1)': 500000,
    'Tidak Mengenakan Helm Standar SNI (Pasal 291 ayat 1)': 250000,
    'Melawan Arus Lalu Lintas (Pasal 287 ayat 1)': 500000,
    'Menerobos Jalur Khusus Busway (Pasal 287 ayat 1)': 500000,
    'Menggunakan Knalpot Bising / Brong (Pasal 285 ayat 1)': 250000,
    'Tidak Menggunakan Sabuk Pengaman Mobil (Pasal 289)': 250000,
    'Tidak Menyalakan Lampu Sein Saat Berbelok (Pasal 294)': 250000,
  };
  final Set<String> _selectedViolations = {};

  // --- ITE filter ---
  bool _onlyComplaintDelict = false;

  @override
  void initState() {
    super.initState();
    _calculateOvertime();
    _calculateSeverance();
    _calculateThr();
  }

  @override
  void dispose() {
    _overtimeSalaryController.dispose();
    _overtimeHoursController.dispose();
    _severanceSalaryController.dispose();
    _severanceYearsController.dispose();
    _severanceMonthsController.dispose();
    _severanceUphController.dispose();
    _thrSalaryController.dispose();
    _thrMonthsController.dispose();
    super.dispose();
  }

  void _copyResult(String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), backgroundColor: AppColors.of(context).success),
      );
  }

  // --- Calculations (§VAL: every input validated before it reaches math) ---
  void _calculateOvertime() {
    final salaryErr = AppValidators.validateSalary(_overtimeSalaryController.text);
    final hoursErr =
        AppValidators.validateOvertimeHours(_overtimeHoursController.text);

    if (salaryErr != null) {
      setState(() => _overtimeError = salaryErr);
      return;
    }
    if (hoursErr != null) {
      setState(() => _overtimeError = hoursErr);
      return;
    }

    final salary =
        double.parse(_overtimeSalaryController.text.replaceAll(RegExp(r'[^0-9]'), ''));
    final hours = double.parse(_overtimeHoursController.text.trim());

    // PP 35/2021: hourly wage = 1/173 of the monthly wage.
    final hourly = salary / 173.0;
    double total;

    if (!_isHoliday) {
      // Regular day: first hour 1.5x, the rest 2x.
      total = hours <= 1
          ? hours * 1.5 * hourly
          : (1.5 * hourly) + ((hours - 1) * 2.0 * hourly);
    } else {
      // Official holiday (5-day week): hours 1-8 at 2x, hour 9 at 3x, 10-12 at 4x.
      if (hours <= 8) {
        total = hours * 2.0 * hourly;
      } else if (hours <= 9) {
        total = (8 * 2.0 * hourly) + ((hours - 8) * 3.0 * hourly);
      } else {
        total = (8 * 2.0 * hourly) +
            (1 * 3.0 * hourly) +
            ((hours - 9) * 4.0 * hourly);
      }
    }

    setState(() {
      _overtimeError = null;
      _overtimePay = total;
    });
  }

  void _calculateSeverance() {
    final salaryErr = AppValidators.validateSalary(_severanceSalaryController.text);
    final yearsErr = AppValidators.validateTenureYears(_severanceYearsController.text);
    final monthsErr = AppValidators.validateTenureMonths(_severanceMonthsController.text);

    if (salaryErr != null) {
      setState(() => _severanceError = salaryErr);
      return;
    }
    if (yearsErr != null) {
      setState(() => _severanceError = yearsErr);
      return;
    }
    if (monthsErr != null) {
      setState(() => _severanceError = monthsErr);
      return;
    }

    final salary =
        double.parse(_severanceSalaryController.text.replaceAll(RegExp(r'[^0-9]'), ''));
    final years = int.parse(_severanceYearsController.text.trim());
    final months = int.tryParse(_severanceMonthsController.text.trim()) ?? 0;
    final uph =
        double.tryParse(_severanceUphController.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
            0.0;

    final result = SeveranceCalculatorEngine.calculate(
      monthlyWage: salary,
      tenureYears: years,
      tenureMonths: months,
      reason: _phkReason,
      manualUph: uph,
    );

    setState(() {
      _severanceError = null;
      _severanceResult = result;
    });
  }

  void _calculateThr() {
    final salaryErr = AppValidators.validateSalary(_thrSalaryController.text);
    if (salaryErr != null) {
      setState(() => _thrError = salaryErr);
      return;
    }

    final months = int.tryParse(_thrMonthsController.text.trim());
    if (months == null || months <= 0) {
      setState(() => _thrError = AppLocalizations.of(context)!.thrMonthsNeeded);
      return;
    }
    if (months > 600) {
      setState(() => _thrError = AppLocalizations.of(context)!.tenureMaxMonthError);
      return;
    }

    final salary =
        double.parse(_thrSalaryController.text.replaceAll(RegExp(r'[^0-9]'), ''));

    // Permenaker 6/2016: proportional below 12 months of service.
    final thr = months < 12 ? (months / 12.0) * salary : salary;

    setState(() {
      _thrError = null;
      _thrPay = thr;
    });
  }

  int get _totalFine =>
      _selectedViolations.fold(0, (sum, v) => sum + (_violations[v] ?? 0));

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppSpacing.lg,
        title: Text(l10n.simulationAndCalculator),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, 0),
            child: _TabBar(
              selected: _selectedTab,
              onChanged: (i) => setState(() => _selectedTab = i),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.xxl),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 640),
                  child: switch (_selectedTab) {
                    0 => _OvertimeTab(
                        salaryController: _overtimeSalaryController,
                        hoursController: _overtimeHoursController,
                        isHoliday: _isHoliday,
                        error: _overtimeError,
                        pay: _overtimePay,
                        onHolidayChanged: (v) {
                          setState(() => _isHoliday = v);
                          _calculateOvertime();
                        },
                        onInputChanged: _calculateOvertime,
                        onCopy: _copyOvertime,
                        formatRupiah: _rupiah.format,
                      ),
                    1 => _SeveranceTab(
                        salaryController: _severanceSalaryController,
                        yearsController: _severanceYearsController,
                        monthsController: _severanceMonthsController,
                        uphController: _severanceUphController,
                        reason: _phkReason,
                        result: _severanceResult,
                        error: _severanceError,
                        onReasonChanged: (r) {
                          setState(() => _phkReason = r);
                          _calculateSeverance();
                        },
                        onInputChanged: _calculateSeverance,
                        onCopy: _copySeverance,
                        formatRupiah: _rupiah.format,
                      ),
                    2 => _ThrTab(
                        salaryController: _thrSalaryController,
                        monthsController: _thrMonthsController,
                        error: _thrError,
                        pay: _thrPay,
                        onInputChanged: _calculateThr,
                        onCopy: _copyThr,
                        formatRupiah: _rupiah.format,
                      ),
                    3 => _TrafficFineTab(
                        violations: _violations,
                        selected: _selectedViolations,
                        totalFine: _totalFine,
                        onToggle: (v) => setState(() {
                          if (!_selectedViolations.remove(v)) {
                            _selectedViolations.add(v);
                          }
                        }),
                        onClear: () => setState(() => _selectedViolations.clear()),
                        formatRupiah: _rupiah.format,
                      ),
                    _ => _CyberPenaltyTab(
                        onlyComplaint: _onlyComplaintDelict,
                        onFilterChanged: (v) =>
                            setState(() => _onlyComplaintDelict = v),
                        formatRupiah: _rupiah.format,
                      ),
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _copyOvertime() {
    final l10n = AppLocalizations.of(context)!;
    _copyResult(
      'Simulasi Lembur RuleBook\n'
      'Gaji: ${_overtimeSalaryController.text}\n'
      'Jam: ${_overtimeHoursController.text}\n'
      'Estimasi upah: ${_rupiah.format(_overtimePay)}\n'
      'Dasar: PP 35/2021',
      l10n.overtimeCopiedSuccess,
    );
  }

  void _copySeverance() {
    final l10n = AppLocalizations.of(context)!;
    final r = _severanceResult;
    if (r == null) return;
    _copyResult(
      'Simulasi Kompensasi PHK RuleBook\n'
      'Upah: ${_rupiah.format(r.monthlyWage)}\n'
      'Masa kerja: ${r.tenureYears} th ${r.tenureMonths} bln\n'
      'Alasan: ${r.reason.title}\n'
      'Pesangon: ${_rupiah.format(r.calculatedPesangon)}\n'
      'UPMK: ${_rupiah.format(r.calculatedUpmk)}\n'
      'UPH: ${_rupiah.format(r.compensationRights)}\n'
      'Total: ${_rupiah.format(r.totalSeverancePay)}\n'
      'Dasar: ${r.reason.legalArticle}',
      l10n.severanceCopiedSuccess,
    );
  }

  void _copyThr() {
    final l10n = AppLocalizations.of(context)!;
    _copyResult(
      'Simulasi THR RuleBook\n'
      'Upah: ${_thrSalaryController.text}\n'
      'Masa kerja: ${_thrMonthsController.text} bulan\n'
      'Hak THR: ${_rupiah.format(_thrPay)}\n'
      'Wajib dibayar paling lambat H-7 hari raya',
      l10n.thrCopiedSuccess,
    );
  }
}

/// Horizontal tab pills, one row, scrollable when narrow.
class _TabBar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;

  const _TabBar({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = AppColors.of(context);
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final labels = [
            l10n.tabOvertimePay,
            l10n.tabSeverancePay,
            l10n.tabProratedThr,
            l10n.tabTrafficFine,
            l10n.tabCyberIteSanctions,
          ];
          final icons = [
            AppIconData.clock,
            AppIconData.briefcase,
            AppIconData.gift,
            AppIconData.traffic,
            AppIconData.lock,
          ];
          final isSelected = selected == index;
          return Material(
            color: isSelected ? c.brand : c.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.sm + 2),
              side: BorderSide(color: isSelected ? c.brand : c.border),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => onChanged(index),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(
                      icons[index],
                      size: 14,
                      color: isSelected ? c.onBrand : c.textMuted,
                      strokeWidth: 1.9,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      labels[index],
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? c.onBrand : c.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// The legal reference strip that opens every tab.
class _LegalNote extends StatelessWidget {
  final AppIconData icon;
  final Color tone;
  final String text;

  const _LegalNote({required this.icon, required this.tone, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppIcon(icon, size: 16, color: tone),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.of(context).textSecondary,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}

/// Labeled numeric field with rupiah formatting helpers.
class _AmountField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String prefix;
  final VoidCallback onChanged;
  final bool decimal;

  const _AmountField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.prefix,
    required this.onChanged,
    this.decimal = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: decimal
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(decimal ? r'[0-9.,]' : r'[0-9]')),
      ],
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixText: prefix,
      ),
      onChanged: (_) => onChanged(),
    );
  }
}

/// Shared result card: one number, one context line, a breakdown, copy action.
class _ResultCard extends StatelessWidget {
  final String title;
  final String amount;
  final String subtitle;
  final List<String> details;
  final VoidCallback onCopy;
  final Color amountColor;

  const _ResultCard({
    required this.title,
    required this.amount,
    required this.subtitle,
    required this.details,
    required this.onCopy,
    required this.amountColor,
  });

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return AppCard(
      color: c.surfaceSunken,
      borderColor: c.border,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: c.textMuted,
                  ),
                ),
              ),
              IconButton(
                tooltip: l10n.copyResults,
                icon: AppIcon(AppIconData.copy, size: 17, color: c.brand),
                onPressed: onCopy,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: amountColor,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(color: c.textMuted),
          ),
          const Divider(height: 24),
          ...details.map(
            (d) => Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration:
                          BoxDecoration(color: c.textFaint, shape: BoxShape.circle),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      d,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: c.textSecondary,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorText extends StatelessWidget {
  final String? error;

  const _ErrorText(this.error);

  @override
  Widget build(BuildContext context) {
    if (error == null) return const SizedBox.shrink();
    final c = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppIcon(AppIconData.warning, size: 15, color: c.danger),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              error!,
              style: TextStyle(
                color: c.danger,
                fontSize: 12.5,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- TAB 0: Overtime ---
class _OvertimeTab extends StatelessWidget {
  final TextEditingController salaryController;
  final TextEditingController hoursController;
  final bool isHoliday;
  final String? error;
  final double pay;
  final ValueChanged<bool> onHolidayChanged;
  final VoidCallback onInputChanged;
  final VoidCallback onCopy;
  final String Function(double) formatRupiah;

  const _OvertimeTab({
    required this.salaryController,
    required this.hoursController,
    required this.isHoliday,
    required this.error,
    required this.pay,
    required this.onHolidayChanged,
    required this.onInputChanged,
    required this.onCopy,
    required this.formatRupiah,
  });

  double get _hourly {
    final salary = double.tryParse(
            salaryController.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
        0;
    return salary / 173.0;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = AppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _LegalNote(icon: AppIconData.info, tone: c.brand, text: l10n.overtimeLegalBasis),
        const SizedBox(height: AppSpacing.lg),
        _AmountField(
          controller: salaryController,
          label: l10n.monthlyBasicSalaryRp,
          hint: '5000000',
          prefix: 'Rp ',
          onChanged: onInputChanged,
        ),
        const SizedBox(height: AppSpacing.md),
        _AmountField(
          controller: hoursController,
          label: l10n.totalOvertimeHours,
          hint: l10n.exampleOvertimeHours,
          prefix: '',
          onChanged: onInputChanged,
          decimal: true,
        ),
        const SizedBox(height: AppSpacing.sm),
        SwitchListTile(
          value: isHoliday,
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.overtimeHolidayTitle,
              style: Theme.of(context).textTheme.titleSmall),
          subtitle: Text(l10n.overtimeHolidayDesc,
              style: Theme.of(context).textTheme.bodySmall),
          onChanged: onHolidayChanged,
        ),
        _ErrorText(error),
        const SizedBox(height: AppSpacing.md),
        _ResultCard(
          title: l10n.estimatedOvertimePay,
          amount: formatRupiah(pay),
          subtitle: isHoliday ? l10n.overtimeRateHoliday : l10n.overtimeRateRegular,
          amountColor: c.success,
          details: [
            '${l10n.hourlyWage}: ${formatRupiah(_hourly)}',
            '${l10n.totalHoursLabel}: ${hoursController.text.trim()} ${l10n.hoursUnit}',
            '${l10n.overtimeHolidayTitle}: ${isHoliday ? l10n.yes : l10n.no}',
          ],
          onCopy: onCopy,
        ),
      ],
    );
  }
}

// --- TAB 1: Severance ---
class _SeveranceTab extends StatelessWidget {
  final TextEditingController salaryController;
  final TextEditingController yearsController;
  final TextEditingController monthsController;
  final TextEditingController uphController;
  final PhkReason reason;
  final SeveranceResult? result;
  final String? error;
  final ValueChanged<PhkReason> onReasonChanged;
  final VoidCallback onInputChanged;
  final VoidCallback onCopy;
  final String Function(double) formatRupiah;

  const _SeveranceTab({
    required this.salaryController,
    required this.yearsController,
    required this.monthsController,
    required this.uphController,
    required this.reason,
    required this.result,
    required this.error,
    required this.onReasonChanged,
    required this.onInputChanged,
    required this.onCopy,
    required this.formatRupiah,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = AppColors.of(context);
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _LegalNote(
            icon: AppIconData.gavel, tone: c.catLabor, text: l10n.severanceLegalBasis),
        const SizedBox(height: AppSpacing.lg),
        _AmountField(
          controller: salaryController,
          label: l10n.basicSalaryFixedAllowance,
          hint: '6500000',
          prefix: 'Rp ',
          onChanged: onInputChanged,
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _AmountField(
                controller: yearsController,
                label: l10n.yearsOfService,
                hint: '3',
                prefix: '',
                onChanged: onInputChanged,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _AmountField(
                controller: monthsController,
                label: l10n.serviceExtraMonths,
                hint: '6',
                prefix: '',
                onChanged: onInputChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        DropdownButtonFormField<PhkReason>(
          initialValue: reason,
          isExpanded: true,
          decoration: InputDecoration(
            labelText: l10n.terminationReason,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 4, right: 2),
              child: AppIcon(AppIconData.scale, size: 19, color: c.textMuted),
            ),
          ),
          items: SeveranceCalculatorEngine.reasons
              .map(
                (r) => DropdownMenuItem<PhkReason>(
                  value: r,
                  child: Text(
                    r.title,
                    style: const TextStyle(fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              )
              .toList(),
          onChanged: (v) {
            if (v != null) onReasonChanged(v);
          },
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          '${reason.legalArticle} · Pesangon ${reason.pesangonFactor}x · UPMK ${reason.upmkFactor}x',
          style: theme.textTheme.labelSmall?.copyWith(color: c.textMuted),
        ),
        const SizedBox(height: AppSpacing.md),
        _AmountField(
          controller: uphController,
          label: l10n.uphCompensation,
          hint: '0',
          prefix: 'Rp ',
          onChanged: onInputChanged,
        ),
        _ErrorText(error),
        const SizedBox(height: AppSpacing.md),
        if (result != null)
          _ResultCard(
            title: l10n.totalSeverancePayTitle,
            amount: formatRupiah(result!.totalSeverancePay),
            subtitle: reason.title,
            amountColor: c.success,
            details: [
              '${l10n.severancePayLabel} (${result!.basePesangonMonths} bln × ${reason.pesangonFactor}x): ${formatRupiah(result!.calculatedPesangon)}',
              '${l10n.upmkPayLabel} (${result!.baseUpmkMonths} bln × ${reason.upmkFactor}x): ${formatRupiah(result!.calculatedUpmk)}',
              '${l10n.uphCompensation}: ${formatRupiah(result!.compensationRights)}',
              '${l10n.legalBasisLabel}: ${reason.legalArticle}',
            ],
            onCopy: onCopy,
          ),
      ],
    );
  }
}

// --- TAB 2: THR ---
class _ThrTab extends StatelessWidget {
  final TextEditingController salaryController;
  final TextEditingController monthsController;
  final String? error;
  final double pay;
  final VoidCallback onInputChanged;
  final VoidCallback onCopy;
  final String Function(double) formatRupiah;

  const _ThrTab({
    required this.salaryController,
    required this.monthsController,
    required this.error,
    required this.pay,
    required this.onInputChanged,
    required this.onCopy,
    required this.formatRupiah,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = AppColors.of(context);
    final months = int.tryParse(monthsController.text.trim()) ?? 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _LegalNote(
            icon: AppIconData.gift,
            tone: c.catConsumer,
            text: l10n.thrLegalBasis),
        const SizedBox(height: AppSpacing.lg),
        _AmountField(
          controller: salaryController,
          label: l10n.monthlyNetWage,
          hint: '5000000',
          prefix: 'Rp ',
          onChanged: onInputChanged,
        ),
        const SizedBox(height: AppSpacing.md),
        _AmountField(
          controller: monthsController,
          label: l10n.continuousServiceMonths,
          hint: l10n.exampleEightMonths,
          prefix: '',
          onChanged: onInputChanged,
        ),
        _ErrorText(error),
        const SizedBox(height: AppSpacing.md),
        _ResultCard(
          title: l10n.estimatedThrTitle,
          amount: formatRupiah(pay),
          subtitle: months >= 12 ? l10n.thrRuleFull : l10n.thrRuleProrate,
          amountColor: c.success,
          details: [
            l10n.thrDeadlineDetail,
            l10n.thrCashOnlyDetail,
            l10n.thrLatePenalty,
          ],
          onCopy: onCopy,
        ),
      ],
    );
  }
}

// --- TAB 3: Traffic fines ---
class _TrafficFineTab extends StatelessWidget {
  final Map<String, int> violations;
  final Set<String> selected;
  final int totalFine;
  final ValueChanged<String> onToggle;
  final VoidCallback onClear;
  final String Function(int) formatRupiah;

  const _TrafficFineTab({
    required this.violations,
    required this.selected,
    required this.totalFine,
    required this.onToggle,
    required this.onClear,
    required this.formatRupiah,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = AppColors.of(context);
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _LegalNote(
            icon: AppIconData.traffic,
            tone: c.catTraffic,
            text: l10n.trafficLegalBasis),
        const SizedBox(height: AppSpacing.lg),
        AppCard(
          color: totalFine > 0 ? c.dangerSoft : c.surfaceSunken,
          borderColor:
              totalFine > 0 ? c.danger.withValues(alpha: 0.3) : c.border,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.totalEstimatedMaxFine,
                      style: theme.textTheme.labelMedium
                          ?.copyWith(color: c.textMuted),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatRupiah(totalFine),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: totalFine > 0 ? c.danger : c.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              if (selected.isNotEmpty)
                TextButton(
                  onPressed: onClear,
                  style: TextButton.styleFrom(
                    minimumSize: const Size(0, 36),
                    visualDensity: VisualDensity.compact,
                  ),
                  child: Text(l10n.resetSelection),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(l10n.selectViolationsHint, style: theme.textTheme.titleSmall),
        const SizedBox(height: AppSpacing.md),
        ...violations.entries.map((entry) {
          final isSelected = selected.contains(entry.key);
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: AppCard(
              onTap: () => onToggle(entry.key),
              color: isSelected ? c.dangerSoft : c.surface,
              borderColor: isSelected
                  ? c.danger.withValues(alpha: 0.35)
                  : c.border,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: 6),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: isSelected,
                      onChanged: (_) => onToggle(entry.key),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      entry.key,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: c.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    formatRupiah(entry.value),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isSelected ? c.danger : c.textMuted,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

// --- TAB 4: ITE / cyber penalties ---
class _CyberPenaltyTab extends StatelessWidget {
  final bool onlyComplaint;
  final ValueChanged<bool> onFilterChanged;
  final String Function(int) formatRupiah;

  const _CyberPenaltyTab({
    required this.onlyComplaint,
    required this.onFilterChanged,
    required this.formatRupiah,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = AppColors.of(context);
    final theme = Theme.of(context);

    final items = CyberPenaltyDatabase.items
        .where((i) => !onlyComplaint || i.isComplaintDelict)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _LegalNote(
            icon: AppIconData.lock,
            tone: c.catPrivacy,
            text: l10n.iteLegalBasis),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            SizedBox(
              height: 32,
              child: FilterChip(
                label: Text(l10n.complaintOffenseOnly,
                    style: const TextStyle(fontSize: 12)),
                selected: onlyComplaint,
                showCheckmark: false,
                onSelected: onFilterChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        ...items.map((item) {
          final tone = item.isComplaintDelict ? c.brand : c.danger;
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: AppCard(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Pill(
                        label: item.isComplaintDelict
                            ? l10n.complaintOffense
                            : l10n.ordinaryOffense,
                        tone: tone,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.articleReference,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: c.textMuted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    item.description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: c.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      Pill(
                        label:
                            '${l10n.maxPrison} ${item.maxPrisonYears} ${l10n.yearsUnit}',
                        icon: AppIconData.warning,
                        tone: c.danger,
                      ),
                      Pill(
                        label:
                            '${l10n.maxFine} ${formatRupiah(item.maxFineRupiah)}',
                        icon: AppIconData.wallet,
                        tone: c.catConsumer,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: c.surfaceSunken,
                      borderRadius:
                          BorderRadius.circular(AppRadius.sm + 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppIcon(AppIconData.bulb,
                                size: 14, color: c.warning),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${l10n.legalTips}: ${item.guidance}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: c.textSecondary,
                                  height: 1.45,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (item.publicDefenseExemption.isNotEmpty &&
                            !item.publicDefenseExemption
                                .startsWith('Tidak')) ...[
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppIcon(AppIconData.shield,
                                  size: 14, color: c.success),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '${l10n.defenseExemption}: ${item.publicDefenseExemption}',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: c.success,
                                    height: 1.45,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
