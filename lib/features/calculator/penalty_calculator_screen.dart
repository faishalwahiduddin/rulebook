import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/models/cyber_penalty_models.dart';
import '../../core/models/severance_calculator_models.dart';
import '../../core/utils/validators.dart';
import '../../l10n/app_localizations.dart';

class PenaltyCalculatorScreen extends StatefulWidget {
  const PenaltyCalculatorScreen({super.key});

  @override
  State<PenaltyCalculatorScreen> createState() => _PenaltyCalculatorScreenState();
}

class _PenaltyCalculatorScreenState extends State<PenaltyCalculatorScreen> {
  int _selectedTab = 0; // 0=Lembur, 1=Pesangon, 2=THR, 3=Tilang, 4=UU ITE

  final _currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  // --- LEMBUR STATE ---
  final TextEditingController _overtimeSalaryController = TextEditingController(text: '5000000');
  final TextEditingController _overtimeHoursController = TextEditingController(text: '3');
  bool _isHoliday = false;
  double _calculatedOvertimePay = 0;
  String? _overtimeError;

  // --- PESANGON STATE ---
  final TextEditingController _severanceSalaryController = TextEditingController(text: '6500000');
  final TextEditingController _severanceYearsController = TextEditingController(text: '3');
  final TextEditingController _severanceMonthsController = TextEditingController(text: '6');
  final TextEditingController _severanceUphController = TextEditingController(text: '0');
  PhkReason _selectedPhkReason = SeveranceCalculatorEngine.reasons[0];
  SeveranceResult? _severanceResult;
  String? _severanceError;

  // --- THR STATE ---
  final TextEditingController _thrSalaryController = TextEditingController(text: '5000000');
  final TextEditingController _thrMonthsController = TextEditingController(text: '8');
  double _calculatedThr = 0;
  String? _thrError;

  // --- TILANG STATE ---
  final Map<String, int> _violations = {
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

  // --- UU ITE FILTER STATE ---
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

  void _copyToClipboard(String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // --- CALCULATION LOGIC (§VAL) ---
  void _calculateOvertime() {
    final salaryErr = AppValidators.validateSalary(_overtimeSalaryController.text);
    final hoursErr = AppValidators.validateOvertimeHours(_overtimeHoursController.text);

    if (salaryErr != null) {
      setState(() => _overtimeError = salaryErr);
      return;
    }
    if (hoursErr != null) {
      setState(() => _overtimeError = hoursErr);
      return;
    }

    final salary = double.parse(_overtimeSalaryController.text.replaceAll(RegExp(r'[^0-9]'), ''));
    final hours = double.parse(_overtimeHoursController.text.trim());

    // PP 35/2021: Upah sejam = 1 / 173 x Upah Bulanan
    final hourlyRate = salary / 173.0;
    double total = 0;

    if (!_isHoliday) {
      // Hari kerja biasa: Jam 1 = 1.5x, Jam berikutnya = 2.0x
      if (hours <= 1) {
        total = hours * 1.5 * hourlyRate;
      } else {
        total = (1.5 * hourlyRate) + ((hours - 1) * 2.0 * hourlyRate);
      }
    } else {
      // Hari libur resmi (5 hari kerja seminggu):
      // Jam 1-8: 2x upah sejam, Jam 9: 3x, Jam 10-12: 4x
      if (hours <= 8) {
        total = hours * 2.0 * hourlyRate;
      } else if (hours == 9) {
        total = (8 * 2.0 * hourlyRate) + (1 * 3.0 * hourlyRate);
      } else {
        total = (8 * 2.0 * hourlyRate) + (1 * 3.0 * hourlyRate) + ((hours - 9) * 4.0 * hourlyRate);
      }
    }

    setState(() {
      _overtimeError = null;
      _calculatedOvertimePay = total;
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

    final salary = double.parse(_severanceSalaryController.text.replaceAll(RegExp(r'[^0-9]'), ''));
    final years = int.parse(_severanceYearsController.text.trim());
    final months = int.tryParse(_severanceMonthsController.text.trim()) ?? 0;
    final uph = double.tryParse(_severanceUphController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0.0;

    final result = SeveranceCalculatorEngine.calculate(
      monthlyWage: salary,
      tenureYears: years,
      tenureMonths: months,
      reason: _selectedPhkReason,
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

    final monthsText = _thrMonthsController.text.trim();
    final months = int.tryParse(monthsText);
    if (months == null || months <= 0) {
      setState(() => _thrError = 'Masa kerja harus berupa angka minimal 1 bulan');
      return;
    }
    if (months > 600) {
      setState(() => _thrError = 'Masa kerja maksimal 600 bulan');
      return;
    }

    final salary = double.parse(_thrSalaryController.text.replaceAll(RegExp(r'[^0-9]'), ''));

    double thr = 0;
    if (months < 1) {
      thr = 0;
    } else if (months < 12) {
      thr = (months / 12.0) * salary;
    } else {
      thr = salary;
    }

    setState(() {
      _thrError = null;
      _calculatedThr = thr;
    });
  }

  int get _totalFine {
    int sum = 0;
    for (final v in _selectedViolations) {
      sum += _violations[v] ?? 0;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.simulationAndCalculator),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Tab Switcher (Scrollable horizontally)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildTabButton(0, l10n.tabOvertimePay, Icons.access_time),
                      const SizedBox(width: 8),
                      _buildTabButton(1, l10n.tabSeverancePay, Icons.work_outline),
                      const SizedBox(width: 8),
                      _buildTabButton(2, l10n.tabProratedThr, Icons.card_giftcard),
                      const SizedBox(width: 8),
                      _buildTabButton(3, l10n.tabTrafficFine, Icons.traffic),
                      const SizedBox(width: 8),
                      _buildTabButton(4, l10n.tabCyberIteSanctions, Icons.security),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Active Tab Content
                if (_selectedTab == 0) _buildOvertimeTab(l10n),
                if (_selectedTab == 1) _buildSeveranceTab(l10n),
                if (_selectedTab == 2) _buildThrTab(l10n),
                if (_selectedTab == 3) _buildTrafficFineTab(l10n),
                if (_selectedTab == 4) _buildCyberPenaltyTab(l10n),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(int index, String label, IconData icon) {
    final isSelected = _selectedTab == index;
    return InkWell(
      onTap: () => setState(() => _selectedTab = index),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.bgSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryLight : AppColors.border,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: isSelected ? Colors.white : const Color(0xFF94A3B8)),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                color: isSelected ? Colors.white : const Color(0xFFCBD5E1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // TAB 0: UPAH LEMBUR (PP 35/2021)
  // ==========================================
  Widget _buildOvertimeTab(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: AppColors.primaryLight, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.overtimeLegalBasis,
                  style: TextStyle(fontSize: 12, color: Color(0xFFCBD5E1), height: 1.35),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        TextField(
          controller: _overtimeSalaryController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: l10n.monthlyBasicSalaryRp,
            prefixIcon: Icon(Icons.payments_outlined),
            hintText: '5000000',
          ),
          onChanged: (_) => _calculateOvertime(),
        ),
        const SizedBox(height: 16),

        TextField(
          controller: _overtimeHoursController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: l10n.totalOvertimeHours,
            prefixIcon: Icon(Icons.timer_outlined),
            hintText: l10n.exampleOvertimeHours,
          ),
          onChanged: (_) => _calculateOvertime(),
        ),
        const SizedBox(height: 14),

        SwitchListTile(
          value: _isHoliday,
          contentPadding: EdgeInsets.zero,
          activeThumbColor: AppColors.primaryLight,
          title: Text(l10n.overtimeHolidayTitle, style: const TextStyle(fontSize: 13, color: Colors.white)),
          subtitle: Text(l10n.overtimeHolidayDesc, style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
          onChanged: (val) {
            setState(() => _isHoliday = val);
            _calculateOvertime();
          },
        ),

        if (_overtimeError != null) ...[
          const SizedBox(height: 10),
          Text(_overtimeError!, style: const TextStyle(color: AppColors.danger, fontSize: 12)),
        ],
        const SizedBox(height: 24),

        // Result Card
        _buildResultCard(
          title: l10n.estimatedOvertimePay,
          amountText: _currencyFormat.format(_calculatedOvertimePay),
          subtitle: _isHoliday
              ? l10n.overtimeRateHoliday
              : l10n.overtimeRateRegular,
          details: [
            'Upah per Jam (1/173): ${_currencyFormat.format(double.tryParse(_overtimeSalaryController.text.replaceAll(RegExp(r'[^0-9]'), '')) != null ? (double.parse(_overtimeSalaryController.text.replaceAll(RegExp(r'[^0-9]'), '')) / 173) : 0)}',
            'Total Jam: ${_overtimeHoursController.text.trim()} Jam',
            'Status: ${_isHoliday ? "Hari Libur" : "Hari Kerja Normal"}',
          ],
          onCopy: () {
            _copyToClipboard(
              'Simulasi Lembur RuleBook:\nGaji: ${_overtimeSalaryController.text}\nJam: ${_overtimeHoursController.text}\nEstimasi Hak Upah: ${_currencyFormat.format(_calculatedOvertimePay)}\nDasar Hukum: PP 35/2021',
              l10n.overtimeCopiedSuccess,
            );
          },
        ),
      ],
    );
  }

  // ==========================================
  // TAB 1: PESANGON PHK (PP 35/2021)
  // ==========================================
  Widget _buildSeveranceTab(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.laborTag.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.laborTag.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.gavel, color: AppColors.laborTag, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.severanceLegalBasis,
                  style: TextStyle(fontSize: 12, color: Color(0xFFCBD5E1), height: 1.35),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        TextField(
          controller: _severanceSalaryController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: l10n.basicSalaryFixedAllowance,
            prefixIcon: Icon(Icons.account_balance_wallet_outlined),
            hintText: '6500000',
          ),
          onChanged: (_) => _calculateSeverance(),
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _severanceYearsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: l10n.yearsOfService,
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                  hintText: '3',
                ),
                onChanged: (_) => _calculateSeverance(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _severanceMonthsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: l10n.serviceExtraMonths,
                  prefixIcon: Icon(Icons.date_range_outlined),
                  hintText: '6',
                ),
                onChanged: (_) => _calculateSeverance(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Dropdown Alasan PHK
        DropdownButtonFormField<PhkReason>(
          initialValue: _selectedPhkReason,
          isExpanded: true,
          decoration: InputDecoration(
            labelText: l10n.terminationReason,
            prefixIcon: Icon(Icons.rule_outlined),
          ),
          items: SeveranceCalculatorEngine.reasons.map((r) {
            return DropdownMenuItem<PhkReason>(
              value: r,
              child: Text(r.title, style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) {
              setState(() => _selectedPhkReason = val);
              _calculateSeverance();
            }
          },
        ),
        const SizedBox(height: 8),
        Text(
          'Dasar: ${_selectedPhkReason.legalArticle} (Pesangon ${_selectedPhkReason.pesangonFactor}x, UPMK ${_selectedPhkReason.upmkFactor}x)',
          style: const TextStyle(fontSize: 11, color: AppColors.accent, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),

        TextField(
          controller: _severanceUphController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: l10n.uphCompensation,
            prefixIcon: Icon(Icons.add_circle_outline),
            hintText: '0',
          ),
          onChanged: (_) => _calculateSeverance(),
        ),

        if (_severanceError != null) ...[
          const SizedBox(height: 10),
          Text(_severanceError!, style: const TextStyle(color: AppColors.danger, fontSize: 12)),
        ],
        const SizedBox(height: 24),

        if (_severanceResult != null)
          _buildResultCard(
            title: l10n.totalSeverancePayTitle,
            amountText: _currencyFormat.format(_severanceResult!.totalSeverancePay),
            subtitle: _selectedPhkReason.title,
            details: [
              'Uang Pesangon (${_severanceResult!.basePesangonMonths} bln x ${_selectedPhkReason.pesangonFactor}x): ${_currencyFormat.format(_severanceResult!.calculatedPesangon)}',
              'Uang Penghargaan Masa Kerja (${_severanceResult!.baseUpmkMonths} bln x ${_selectedPhkReason.upmkFactor}x): ${_currencyFormat.format(_severanceResult!.calculatedUpmk)}',
              'Uang Penggantian Hak (UPH): ${_currencyFormat.format(_severanceResult!.compensationRights)}',
              'Dasar Hukum: ${_selectedPhkReason.legalArticle}',
            ],
            onCopy: () {
              final r = _severanceResult!;
              _copyToClipboard(
                'Simulasi Kompensasi PHK (PP 35/2021):\nUpah: ${_currencyFormat.format(r.monthlyWage)}\nMasa Kerja: ${r.tenureYears} Thn ${r.tenureMonths} Bln\nAlasan: ${r.reason.title}\nUang Pesangon: ${_currencyFormat.format(r.calculatedPesangon)}\nUPMK: ${_currencyFormat.format(r.calculatedUpmk)}\nUPH: ${_currencyFormat.format(r.compensationRights)}\nTOTAL KOMPENSASI: ${_currencyFormat.format(r.totalSeverancePay)}\nDasar: ${r.reason.legalArticle}',
                l10n.severanceCopiedSuccess,
              );
            },
          ),
      ],
    );
  }

  // ==========================================
  // TAB 2: THR KEAGAMAAN
  // ==========================================
  Widget _buildThrTab(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.consumerTag.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.consumerTag.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.card_giftcard, color: AppColors.consumerTag, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.thrLegalBasis,
                  style: TextStyle(fontSize: 12, color: Color(0xFFCBD5E1), height: 1.35),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        TextField(
          controller: _thrSalaryController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: l10n.monthlyNetWage,
            prefixIcon: Icon(Icons.monetization_on_outlined),
            hintText: '5000000',
          ),
          onChanged: (_) => _calculateThr(),
        ),
        const SizedBox(height: 16),

        TextField(
          controller: _thrMonthsController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: l10n.continuousServiceMonths,
            prefixIcon: Icon(Icons.date_range),
            hintText: l10n.exampleEightMonths,
          ),
          onChanged: (_) => _calculateThr(),
        ),

        if (_thrError != null) ...[
          const SizedBox(height: 10),
          Text(_thrError!, style: const TextStyle(color: AppColors.danger, fontSize: 12)),
        ],
        const SizedBox(height: 24),

        _buildResultCard(
          title: l10n.estimatedThrTitle,
          amountText: _currencyFormat.format(_calculatedThr),
          subtitle: (int.tryParse(_thrMonthsController.text.trim()) ?? 0) >= 12
              ? l10n.thrRuleFull
              : l10n.thrRuleProrate,
          details: [
            'Batas Akhir Pembayaran: H-7 Hari Raya Keagamaan',
            'Bentuk Pembayaran: Wajib Uang Rupiah (Dilarang dalam bentuk barang/bingkisan)',
            l10n.thrLatePenalty,
          ],
          onCopy: () {
            _copyToClipboard(
              'Simulasi THR (Permenaker 6/2016):\nUpah: ${_thrSalaryController.text}\nMasa Kerja: ${_thrMonthsController.text} Bulan\nHak THR: ${_currencyFormat.format(_calculatedThr)}\nWajib dibayar paling lambat H-7!',
              l10n.thrCopiedSuccess,
            );
          },
        ),
      ],
    );
  }

  // ==========================================
  // TAB 3: DENDA TILANG LLAJ (UU 22/2009)
  // ==========================================
  Widget _buildTrafficFineTab(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.trafficTag.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.trafficTag.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.traffic, color: AppColors.trafficTag, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.trafficLegalBasis,
                  style: TextStyle(fontSize: 12, color: Color(0xFFCBD5E1), height: 1.35),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Total Fine Sticky Card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.bgSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _totalFine > 0 ? AppColors.danger.withValues(alpha: 0.5) : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.totalEstimatedMaxFine, style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                  const SizedBox(height: 4),
                  Text(
                    _currencyFormat.format(_totalFine),
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.danger),
                  ),
                ],
              ),
              if (_selectedViolations.isNotEmpty)
                TextButton(
                  onPressed: () => setState(() => _selectedViolations.clear()),
                  child: Text(l10n.resetSelection, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        Text(
          l10n.selectViolationsHint,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        const SizedBox(height: 10),

        ..._violations.entries.map((entry) {
          final isSelected = _selectedViolations.contains(entry.key);
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.danger.withValues(alpha: 0.1) : AppColors.bgCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppColors.danger.withValues(alpha: 0.4) : AppColors.border,
              ),
            ),
            child: CheckboxListTile(
              value: isSelected,
              activeColor: AppColors.danger,
              checkColor: Colors.white,
              onChanged: (_) {
                setState(() {
                  if (isSelected) {
                    _selectedViolations.remove(entry.key);
                  } else {
                    _selectedViolations.add(entry.key);
                  }
                });
              },
              title: Text(entry.key, style: const TextStyle(fontSize: 13, color: Colors.white)),
              subtitle: Text(
                'Maksimal ${_currencyFormat.format(entry.value)}',
                style: const TextStyle(fontSize: 12, color: AppColors.accent, fontWeight: FontWeight.w600),
              ),
            ),
          );
        }),
      ],
    );
  }

  // ==========================================
  // TAB 4: SANKSI SIBER & UU ITE (UU 1/2024)
  // ==========================================
  Widget _buildCyberPenaltyTab(AppLocalizations l10n) {
    final items = CyberPenaltyDatabase.items.where((i) {
      if (_onlyComplaintDelict && !i.isComplaintDelict) return false;
      return true;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.privacyTag.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.privacyTag.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.security, color: AppColors.privacyTag, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.iteLegalBasis,
                  style: TextStyle(fontSize: 12, color: Color(0xFFCBD5E1), height: 1.35),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        FilterChip(
          avatar: const Icon(Icons.filter_list, size: 16),
          label: Text(l10n.complaintOffenseOnly),
          selected: _onlyComplaintDelict,
          selectedColor: AppColors.primary,
          onSelected: (val) => setState(() => _onlyComplaintDelict = val),
        ),
        const SizedBox(height: 16),

        ...items.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: item.isComplaintDelict
                            ? AppColors.primary.withValues(alpha: 0.2)
                            : AppColors.danger.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item.isComplaintDelict ? l10n.complaintOffense : l10n.ordinaryOffense,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: item.isComplaintDelict ? AppColors.primaryLight : AppColors.danger,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  item.articleReference,
                  style: const TextStyle(fontSize: 11, color: AppColors.accent, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Text(
                  item.description,
                  style: const TextStyle(fontSize: 12, color: Color(0xFFCBD5E1), height: 1.35),
                ),
                const SizedBox(height: 12),

                // Prison & Fine Metric Badges
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.danger.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.lock_clock, size: 14, color: AppColors.danger),
                          const SizedBox(width: 4),
                          Text(
                            '${l10n.maxPrison} ${item.maxPrisonYears} ${l10n.yearsUnit}',
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.danger),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.monetization_on, size: 14, color: AppColors.accent),
                          const SizedBox(width: 4),
                          Text(
                            '${l10n.maxFine} ${_currencyFormat.format(item.maxFineRupiah)}',
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.accent),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '💡 ${l10n.legalTips}: ${item.guidance}',
                        style: const TextStyle(fontSize: 11, color: Color(0xFFE2E8F0), height: 1.35),
                      ),
                      if (item.publicDefenseExemption.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          '🛡️ ${l10n.defenseExemption}: ${item.publicDefenseExemption}',
                          style: const TextStyle(fontSize: 11, color: AppColors.success, height: 1.35),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  // Common Result Card Component
  Widget _buildResultCard({
    required String title,
    required String amountText,
    required String subtitle,
    required List<String> details,
    required VoidCallback onCopy,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8))),
              IconButton(
                icon: const Icon(Icons.copy, size: 18, color: AppColors.primaryLight),
                tooltip: 'Salin Hasil', // result copy
                onPressed: onCopy,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            amountText,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: AppColors.success),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Color(0xFFCBD5E1)),
          ),
          const Divider(height: 24, color: AppColors.border),
          ...details.map((d) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(color: AppColors.primaryLight, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Text(d, style: const TextStyle(fontSize: 12, color: Color(0xFFCBD5E1), height: 1.35)),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
