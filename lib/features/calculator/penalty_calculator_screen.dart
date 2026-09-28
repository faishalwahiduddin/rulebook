import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';

class PenaltyCalculatorScreen extends StatefulWidget {
  const PenaltyCalculatorScreen({super.key});

  @override
  State<PenaltyCalculatorScreen> createState() => _PenaltyCalculatorScreenState();
}

class _PenaltyCalculatorScreenState extends State<PenaltyCalculatorScreen> {
  int _selectedTab = 0; // 0 = Lembur, 1 = Tilang

  // Lembur state
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _hoursController = TextEditingController();
  double _calculatedOvertimePay = 0;
  String? _overtimeError;

  // Tilang state
  final Map<String, int> _violations = {
    'Tidak Memiliki SIM yang Sah (Pasal 281)': 1000000,
    'Tidak Membawa STNK Sah (Pasal 288)': 500000,
    'Mengoperasikan HP Saat Mengemudi (Pasal 283)': 750000,
    'Melebihi Batas Kecepatan Maksimal (Pasal 287)': 500000,
    'Tidak Menyalakan Lampu Utama Siang Hari (Pasal 293)': 100000,
    'Melanggar Rambu / Lampu Merah (Pasal 287)': 500000,
  };
  final Set<String> _selectedViolations = {};

  final _currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  void _calculateOvertime() {
    final salaryText = _salaryController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final hoursText = _hoursController.text.trim();

    if (salaryText.isEmpty || hoursText.isEmpty) {
      setState(() => _overtimeError = 'Harap isi gaji pokok dan total jam lembur');
      return;
    }

    final salary = double.tryParse(salaryText) ?? 0;
    final hours = double.tryParse(hoursText) ?? 0;

    if (salary < 100000) {
      setState(() => _overtimeError = 'Gaji pokok minimal Rp 100.000');
      return;
    }
    if (hours <= 0 || hours > 100) {
      setState(() => _overtimeError = 'Jam lembur harus antara 1 dan 100 jam');
      return;
    }

    // PP 35/2021: Upah sejam = 1 / 173 x Upah Bulanan
    final hourlyRate = salary / 173.0;
    double total = 0;
    if (hours <= 1) {
      total = hours * 1.5 * hourlyRate;
    } else {
      total = (1.5 * hourlyRate) + ((hours - 1) * 2.0 * hourlyRate);
    }

    setState(() {
      _overtimeError = null;
      _calculatedOvertimePay = total;
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
  void dispose() {
    _salaryController.dispose();
    _hoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulasi & Kalkulator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Mode Switcher
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.bgSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() => _selectedTab = 0),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: _selectedTab == 0 ? AppColors.primary : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Upah Lembur Resmi',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: _selectedTab == 0 ? FontWeight.w700 : FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() => _selectedTab = 1),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: _selectedTab == 1 ? AppColors.primary : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Estimasi Denda Tilang',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: _selectedTab == 1 ? FontWeight.w700 : FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                if (_selectedTab == 0) _buildOvertimeCalculator() else _buildTrafficFineCalculator(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOvertimeCalculator() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hitung Hak Upah Lembur (PP 35/2021)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            const SizedBox(height: 6),
            const Text(
              'Rumus resmi Depnaker: Upah per jam = Gaji Pokok / 173. Jam ke-1 = 1,5x upah per jam; Jam ke-2 dst = 2x upah per jam.',
              style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8), height: 1.4),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _salaryController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Gaji Pokok / Bulan (Rp)',
                hintText: 'Misal: 5000000',
                prefixIcon: Icon(Icons.payments_outlined, size: 20),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _hoursController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Total Jam Lembur',
                hintText: 'Misal: 4',
                prefixIcon: Icon(Icons.timer_outlined, size: 20),
              ),
            ),
            if (_overtimeError != null) ...[
              const SizedBox(height: 10),
              Text(_overtimeError!, style: const TextStyle(color: AppColors.danger, fontSize: 12)),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateOvertime,
              child: const Text('Hitung Hak Upah Lembur'),
            ),
            if (_calculatedOvertimePay > 0) ...[
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Hak Upah Lembur Wajib Dibayarkan:', style: TextStyle(fontSize: 12, color: AppColors.success)),
                    const SizedBox(height: 6),
                    Text(
                      _currencyFormat.format(_calculatedOvertimePay),
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTrafficFineCalculator() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daftar Batas Denda Maksimal (UU 22/2009)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            const SizedBox(height: 6),
            const Text(
              'Centang pasal pelanggaran untuk melihat akumulasi denda maksimal resmi menurut undang-undang:',
              style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8), height: 1.4),
            ),
            const SizedBox(height: 16),
            ..._violations.entries.map((entry) {
              final isChecked = _selectedViolations.contains(entry.key);
              return CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                activeColor: AppColors.primary,
                title: Text(entry.key, style: const TextStyle(fontSize: 13, color: Colors.white)),
                subtitle: Text(
                  'Denda Maks: ${_currencyFormat.format(entry.value)}',
                  style: const TextStyle(fontSize: 12, color: AppColors.danger, fontWeight: FontWeight.w600),
                ),
                value: isChecked,
                onChanged: (val) {
                  setState(() {
                    if (val == true) {
                      _selectedViolations.add(entry.key);
                    } else {
                      _selectedViolations.remove(entry.key);
                    }
                  });
                },
              );
            }),
            const Divider(color: AppColors.border, height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.danger.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.danger.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Akumulasi Denda Maksimal:', style: TextStyle(fontSize: 12, color: AppColors.danger)),
                  const SizedBox(height: 6),
                  Text(
                    _currencyFormat.format(_totalFine),
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
