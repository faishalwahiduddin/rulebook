import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rulebook/core/providers/app_providers.dart';
import 'package:rulebook/core/storage/local_storage_service.dart';
import 'package:rulebook/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('RuleBookApp smoke test and navigation between tabs', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'locale': 'id'});
    final storageService = await LocalStorageService.init();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localStorageServiceProvider.overrideWithValue(storageService),
        ],
        child: const RuleBookApp(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify main brand and catalog elements
    expect(find.text('RuleBook'), findsOneWidget);
    expect(find.text('Semua'), findsOneWidget);
    expect(find.textContaining('Lalu Lintas'), findsWidgets);
    expect(find.text('Aturan'), findsOneWidget);
    expect(find.text('Hitung'), findsOneWidget);
    expect(find.text('Darurat'), findsOneWidget);
    expect(find.text('Audit'), findsOneWidget);
    expect(find.text('Simpanan'), findsOneWidget);

    // Tap on Hitung tab
    await tester.tap(find.text('Hitung'));
    await tester.pumpAndSettle();
    expect(find.text('Simulasi & Kalkulator'), findsOneWidget);
    expect(find.text('Upah Lembur'), findsWidgets);
    expect(find.text('Pesangon PHK'), findsOneWidget);

    // Tap on Darurat tab
    await tester.tap(find.text('Darurat'));
    await tester.pumpAndSettle();
    expect(find.text('SOP & Panduan Darurat'), findsOneWidget);

    // Tap on Audit tab
    await tester.tap(find.text('Audit'));
    await tester.pumpAndSettle();
    expect(find.text('Audit Kepatuhan Mandiri'), findsOneWidget);

    // Tap on Simpanan tab
    await tester.tap(find.text('Simpanan'));
    await tester.pumpAndSettle();
    expect(find.text('Tersimpan & Catatan'), findsOneWidget);
  });
}
