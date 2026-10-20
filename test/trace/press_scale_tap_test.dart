import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rulebook/core/ui/press_scale.dart';
import 'package:rulebook/core/ui/tap_target.dart';

void main() {
  // TapTarget(child: PressScale(...)) is the documented pattern for icon
  // actions (bookmark). PressScale must not steal the tap from TapTarget.
  testWidgets('FLOW-BKM-01-T05 ikon simpan (TapTarget + PressScale) memicu aksi saat diketuk', (tester) async {
    var taps = 0;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: TapTarget(
            semanticLabel: 'Simpan aturan',
            haptic: false,
            onTap: () => taps++,
            child: const PressScale(child: Icon(Icons.bookmark_border)),
          ),
        ),
      ),
    ));
    await tester.tap(find.byIcon(Icons.bookmark_border));
    await tester.pumpAndSettle();
    expect(taps, 1);
  });
}
