import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rulebook/core/providers/app_providers.dart';
import 'package:rulebook/core/storage/local_storage_service.dart';
import 'package:rulebook/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('RuleBookApp smoke test', (WidgetTester tester) async {
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
  });
}
