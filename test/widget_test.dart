import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rulebook/core/providers/app_providers.dart';
import 'package:rulebook/core/storage/local_storage_service.dart';
import 'package:rulebook/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('RuleBookApp smoke test and navigation between tabs', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
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
    expect(find.text('Lalu Lintas'), findsWidgets);
    expect(find.text('Katalog'), findsOneWidget);
    expect(find.text('Simulasi'), findsOneWidget);
    expect(find.text('SOP Darurat'), findsOneWidget);
    expect(find.text('Kepatuhan'), findsOneWidget);
    expect(find.text('Tersimpan'), findsOneWidget);

    // Tap on Simulasi tab
    await tester.tap(find.text('Simulasi'));
    await tester.pumpAndSettle();
    expect(find.text('Simulasi & Kalkulator'), findsOneWidget);
    expect(find.text('Upah Lembur'), findsWidgets);
    expect(find.text('Pesangon PHK'), findsOneWidget);

    // Tap on SOP Darurat tab
    await tester.tap(find.text('SOP Darurat'));
    await tester.pumpAndSettle();
    expect(find.text('SOP & Panduan Darurat'), findsOneWidget);

    // Tap on Kepatuhan tab
    await tester.tap(find.text('Kepatuhan'));
    await tester.pumpAndSettle();
    expect(find.text('Audit Kepatuhan Mandiri'), findsOneWidget);

    // Tap on Tersimpan tab
    await tester.tap(find.text('Tersimpan'));
    await tester.pumpAndSettle();
    expect(find.text('Tersimpan & Catatan'), findsOneWidget);
  });
}
