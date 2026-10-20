// Contrast guard helper (§TRACE dark-mode audit): walks the render tree and
// measures every painted text against the nearest opaque surface behind it.
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

double contrastRatio(Color a, Color b) {
  final la = a.computeLuminance(), lb = b.computeLuminance();
  final hi = la > lb ? la : lb, lo = la > lb ? lb : la;
  return (hi + 0.05) / (lo + 0.05);
}

Color _over(Color top, Color bottom) => Color.alphaBlend(top, bottom);

/// Surface colour painted behind [node]: nearest opaque decorated box /
/// Material, blending translucent layers on the way, else [fallback].
Color surfaceBehind(RenderObject node, Color fallback) {
  final layers = <Color>[];
  RenderObject? n = node.parent;
  while (n != null) {
    Color? c;
    if (n is RenderDecoratedBox && n.decoration is BoxDecoration) {
      c = (n.decoration as BoxDecoration).color;
    } else if (n is RenderPhysicalShape) {
      c = n.color;
    } else if (n is RenderPhysicalModel) {
      c = n.color;
    }
    if (c != null && c.a > 0) {
      layers.add(c);
      if (c.a >= 0.99) break;
    }
    n = n.parent;
  }
  var bg = fallback;
  if (layers.isEmpty || layers.last.a < 0.99) {
    // keep fallback as the base
  } else {
    bg = layers.removeLast();
  }
  for (final c in layers.reversed) {
    bg = _over(c, bg);
  }
  return bg;
}

/// One low-contrast finding.
class ContrastIssue {
  ContrastIssue(this.text, this.ratio, this.fg, this.bg);
  final String text;
  final double ratio;
  final Color fg, bg;
  @override
  String toString() => '"$text" ${ratio.toStringAsFixed(2)} (fg ${fg.toARGB32().toRadixString(16)} on ${bg.toARGB32().toRadixString(16)})';
}

/// Scans every visible paragraph on screen; returns texts below [min] contrast.
List<ContrastIssue> scanContrast(WidgetTester tester, {double min = 4.5, Color? fallback}) {
  final base = fallback ?? Theme.of(tester.element(find.byType(Scaffold).last)).scaffoldBackgroundColor;
  final issues = <ContrastIssue>[];
  final screen = tester.view.physicalSize / tester.view.devicePixelRatio;
  // find.* skips offstage subtrees (inactive tabs, covered routes) by default.
  for (final e in find.byType(RichText).evaluate()) {
    final o = e.renderObject;
    if (o is! RenderParagraph || !o.attached || !o.hasSize) continue;
    final txt = o.text.toPlainText().trim();
    final color = o.text.style?.color;
    final box = MatrixUtils.transformRect(o.getTransformTo(null), Offset.zero & o.size);
    final onScreen = box.right > 0 && box.bottom > 0 && box.left < screen.width && box.top < screen.height;
    // Icon fonts paint glyphs from the private-use planes: non-text (WCAG 3:1), not checked here.
    final isIcon = txt.runes.every((r) => (r >= 0xE000 && r <= 0xF8FF) || r >= 0xF0000);
    if (txt.isEmpty || isIcon || color == null || color.a <= 0.5 || !onScreen || !txt.runes.any((r) => r > 0x40)) continue;
    final bg = surfaceBehind(o, base);
    final fg = _over(color, bg);
    final r = contrastRatio(fg, bg);
    if (r < min) issues.add(ContrastIssue(txt.length > 40 ? txt.substring(0, 40) : txt, r, fg, bg));
  }
  return issues;
}
