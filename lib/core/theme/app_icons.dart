import 'dart:math' as math;
import 'package:flutter/material.dart';

/// RuleBook's bespoke icon set.
///
/// Every glyph is drawn on a 24×24 grid with a uniform 1.75px stroke and round
/// caps/joins, so the family reads as one hand. This replaces the generic
/// Material icon soup and the emoji that used to stand in for content icons.
enum AppIconData {
  book,
  calculator,
  shield,
  checklist,
  bookmark,
  bookmarkFilled,
  search,
  gavel,
  scale,
  traffic,
  briefcase,
  lock,
  cart,
  hardhat,
  megaphone,
  chevronRight,
  copy,
  check,
  checkCircle,
  close,
  closeCircle,
  warning,
  info,
  bulb,
  settings,
  globe,
  moon,
  sun,
  auto,
  download,
  trash,
  note,
  phone,
  sparkle,
  clock,
  wallet,
  gift,
  calendar,
  arrowLeft,
  refresh,
  layers,
  filter,
  send,
}

/// Renders an [AppIconData] as a vector at any size / color.
class AppIcon extends StatelessWidget {
  final AppIconData icon;
  final double size;
  final Color? color;
  final double strokeWidth;

  const AppIcon(
    this.icon, {
    super.key,
    this.size = 22,
    this.color,
    this.strokeWidth = 1.75,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _AppIconPainter(
          icon: icon,
          color: color ?? IconTheme.of(context).color ?? const Color(0xFF0F172A),
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _AppIconPainter extends CustomPainter {
  final AppIconData icon;
  final Color color;
  final double strokeWidth;

  _AppIconPainter({
    required this.icon,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24.0;
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;
    final fill = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    Offset p(double x, double y) => Offset(x * s, y * s);
    void line(double x1, double y1, double x2, double y2) =>
        canvas.drawLine(p(x1, y1), p(x2, y2), stroke);
    void path(List<List<double>> pts, {bool close = false}) {
      final pa = Path()..moveTo(pts.first[0] * s, pts.first[1] * s);
      for (final pt in pts.skip(1)) {
        pa.lineTo(pt[0] * s, pt[1] * s);
      }
      if (close) pa.close();
      canvas.drawPath(pa, stroke);
    }

    void circle(double cx, double cy, double r, {bool filled = false}) {
      canvas.drawCircle(p(cx, cy), r * s, filled ? fill : stroke);
    }

    switch (icon) {
      case AppIconData.book:
        // Open book with a center spine.
        path([
          [12, 6.2],
          [7.5, 4.6],
          [4, 5.0],
          [4, 17.8],
          [7.5, 17.4],
          [12, 19.0],
        ]);
        path([
          [12, 6.2],
          [16.5, 4.6],
          [20, 5.0],
          [20, 17.8],
          [16.5, 17.4],
          [12, 19.0],
        ]);
        line(12, 6.2, 12, 19.0);
        break;

      case AppIconData.calculator:
        _roundedRect(canvas, s, 5, 3.5, 14, 17, 2.5, stroke);
        line(5, 8, 19, 8);
        for (var i = 0; i < 3; i++) {
          for (var j = 0; j < 3; j++) {
            circle(8.0 + j * 4, 11.4 + i * 3.1, 0.85, filled: true);
          }
        }
        break;

      case AppIconData.shield:
        path([
          [12, 3.4],
          [19, 6.2],
          [19, 11.6],
          [12, 20.6],
          [5, 11.6],
          [5, 6.2],
        ], close: true);
        line(9.2, 11.8, 11.2, 13.8);
        line(11.2, 13.8, 15.2, 9.6);
        break;

      case AppIconData.checklist:
        _roundedRect(canvas, s, 4.5, 3.5, 15, 17, 2.5, stroke);
        line(8.5, 9, 16, 9);
        line(8.5, 13, 16, 13);
        line(8.5, 17, 13, 17);
        circle(6.2, 9, 0.9, filled: true);
        circle(6.2, 13, 0.9, filled: true);
        circle(6.2, 17, 0.9, filled: true);
        break;

      case AppIconData.bookmark:
        path([
          [6.5, 3.8],
          [17.5, 3.8],
          [17.5, 20.2],
          [12, 15.6],
          [6.5, 20.2],
        ], close: true);
        break;

      case AppIconData.bookmarkFilled:
        final bm = Path()
          ..moveTo(6.5 * s, 3.8 * s)
          ..lineTo(17.5 * s, 3.8 * s)
          ..lineTo(17.5 * s, 20.2 * s)
          ..lineTo(12 * s, 15.6 * s)
          ..lineTo(6.5 * s, 20.2 * s)
          ..close();
        canvas.drawPath(bm, fill);
        break;

      case AppIconData.search:
        circle(10.5, 10.5, 6.2);
        line(15.1, 15.1, 20.5, 20.5);
        break;

      case AppIconData.gavel:
        // Mallet head + handle with a strike line.
        path([
          [13.5, 4.2],
          [19.8, 10.5],
          [17.6, 12.7],
          [11.3, 6.4],
        ], close: true);
        line(11.3, 6.4, 13.5, 4.2);
        line(11.3, 6.4, 7.2, 10.5);
        line(17.6, 12.7, 13.5, 16.8);
        line(12.6, 11.6, 6.8, 17.4);
        line(4.5, 20.2, 15.5, 20.2);
        break;

      case AppIconData.scale:
        // Balanced scales of justice.
        line(12, 3.6, 12, 20);
        line(5.5, 6.2, 18.5, 6.2);
        line(8.5, 19.4, 15.5, 19.4);
        circle(12, 4.4, 1.1);
        path([
          [5.5, 6.2],
          [3.2, 11.2],
          [7.8, 11.2],
        ], close: true);
        path([
          [18.5, 6.2],
          [16.2, 11.2],
          [20.8, 11.2],
        ], close: true);
        break;

      case AppIconData.traffic:
        circle(12, 12, 3.2);
        circle(12, 12, 8.4);
        line(12, 3.6, 12, 5.4);
        line(12, 18.6, 12, 20.4);
        line(3.6, 12, 5.4, 12);
        line(18.6, 12, 20.4, 12);
        break;

      case AppIconData.briefcase:
        _roundedRect(canvas, s, 3.5, 7, 17, 12.5, 2.5, stroke);
        path([
          [8.5, 7],
          [8.5, 5],
          [15.5, 5],
          [15.5, 7],
        ]);
        line(3.5, 12.4, 20.5, 12.4);
        break;

      case AppIconData.lock:
        _roundedRect(canvas, s, 5, 10.5, 14, 10, 2.5, stroke);
        path([
          [8.2, 10.5],
          [8.2, 7.6],
          [15.8, 7.6],
          [15.8, 10.5],
        ]);
        circle(12, 15.5, 1.3, filled: true);
        break;

      case AppIconData.cart:
        circle(9.5, 20, 1.4, filled: true);
        circle(17.5, 20, 1.4, filled: true);
        path([
          [3.5, 4],
          [5.8, 4],
          [7.6, 15],
          [18.6, 15],
          [20.5, 7],
          [6.2, 7],
        ]);
        break;

      case AppIconData.hardhat:
        path([
          [4.5, 16.5],
          [4.5, 14],
          [19.5, 14],
          [19.5, 16.5],
        ]);
        path([
          [6.5, 14],
          [6.5, 9.5],
          [17.5, 9.5],
          [17.5, 14],
        ]);
        line(10.5, 9.5, 10.5, 6.2);
        line(13.5, 9.5, 13.5, 6.2);
        line(10.5, 6.2, 13.5, 6.2);
        line(3.5, 19, 20.5, 19);
        break;

      case AppIconData.megaphone:
        path([
          [4.5, 10],
          [15.5, 5.2],
          [15.5, 18.8],
          [4.5, 14],
        ], close: true);
        line(4.5, 10, 4.5, 14);
        line(15.5, 8, 19, 6.5);
        line(15.5, 16, 19, 17.5);
        line(7.5, 14.5, 8.6, 19);
        break;

      case AppIconData.chevronRight:
        line(9.5, 5.5, 16, 12);
        line(16, 12, 9.5, 18.5);
        break;

      case AppIconData.copy:
        _roundedRect(canvas, s, 8.5, 3.5, 12, 12.5, 2.5, stroke);
        path([
          [5.5, 8],
          [3.5, 8],
          [3.5, 20.5],
          [14.5, 20.5],
          [14.5, 18.5],
        ]);
        break;

      case AppIconData.check:
        line(5, 12.5, 10, 17.5);
        line(10, 17.5, 19, 6.5);
        break;

      case AppIconData.checkCircle:
        circle(12, 12, 8.4);
        line(8.3, 12.2, 11, 14.9);
        line(11, 14.9, 15.8, 9.3);
        break;

      case AppIconData.close:
        line(6.5, 6.5, 17.5, 17.5);
        line(17.5, 6.5, 6.5, 17.5);
        break;

      case AppIconData.closeCircle:
        circle(12, 12, 8.4);
        line(9.2, 9.2, 14.8, 14.8);
        line(14.8, 9.2, 9.2, 14.8);
        break;

      case AppIconData.warning:
        path([
          [12, 3.8],
          [21, 19.5],
          [3, 19.5],
        ], close: true);
        line(12, 9.5, 12, 14);
        circle(12, 16.8, 0.95, filled: true);
        break;

      case AppIconData.info:
        circle(12, 12, 8.4);
        line(12, 11, 12, 16.4);
        circle(12, 7.8, 1.0, filled: true);
        break;

      case AppIconData.bulb:
        path([
          [9, 15.5],
          [9, 13.2],
          [7.6, 10.9],
          [7.6, 9.2],
          [16.4, 9.2],
          [16.4, 10.9],
          [15, 13.2],
          [15, 15.5],
        ]);
        path([
          [9, 15.5],
          [15, 15.5],
        ]);
        line(9.8, 18.2, 14.2, 18.2);
        line(10.6, 20.6, 13.4, 20.6);
        line(12, 3.4, 12, 5.2);
        line(5.6, 6.4, 6.9, 7.7);
        line(18.4, 6.4, 17.1, 7.7);
        break;

      case AppIconData.settings:
        circle(12, 12, 3.1);
        for (var i = 0; i < 8; i++) {
          final a = i * math.pi / 4;
          final inner = 6.2;
          final outer = 8.4;
          canvas.drawLine(
            Offset(12 * s + math.cos(a) * inner * s, 12 * s + math.sin(a) * inner * s),
            Offset(12 * s + math.cos(a) * outer * s, 12 * s + math.sin(a) * outer * s),
            stroke,
          );
        }
        circle(12, 12, 8.4);
        break;

      case AppIconData.globe:
        circle(12, 12, 8.4);
        canvas.drawOval(
          Rect.fromCenter(center: p(12, 12), width: 8.4 * s, height: 16.8 * s),
          stroke,
        );
        line(3.8, 9.2, 20.2, 9.2);
        line(3.8, 14.8, 20.2, 14.8);
        break;

      case AppIconData.moon:
        path([
          [19.5, 14.5],
          [17.6, 15.4],
          [14.8, 14.9],
          [13.1, 12.9],
          [12.6, 10.1],
          [13.8, 7.6],
          [16.2, 6.1],
          [15.4, 4.4],
          [12.6, 3.9],
          [9.4, 4.6],
          [7.2, 6.8],
          [6.4, 9.9],
          [7.2, 13.2],
          [9.6, 15.7],
          [12.8, 16.5],
          [16.1, 15.9],
          [18.4, 14.3],
        ], close: true);
        break;

      case AppIconData.sun:
        circle(12, 12, 4.2);
        for (var i = 0; i < 8; i++) {
          final a = i * math.pi / 4;
          canvas.drawLine(
            Offset(12 * s + math.cos(a) * 6.6 * s, 12 * s + math.sin(a) * 6.6 * s),
            Offset(12 * s + math.cos(a) * 9.0 * s, 12 * s + math.sin(a) * 9.0 * s),
            stroke,
          );
        }
        break;

      case AppIconData.auto:
        circle(12, 12, 8.4);
        final half = Path()
          ..addArc(Rect.fromCircle(center: p(12, 12), radius: 8.4 * s), -math.pi / 2, math.pi)
          ..close();
        canvas.drawPath(half, fill);
        break;

      case AppIconData.download:
        line(12, 4, 12, 15.2);
        path([
          [7.6, 11],
          [12, 15.4],
          [16.4, 11],
        ]);
        path([
          [4.5, 16.5],
          [4.5, 19.5],
          [19.5, 19.5],
          [19.5, 16.5],
        ]);
        break;

      case AppIconData.trash:
        line(4.5, 6.8, 19.5, 6.8);
        path([
          [9.2, 6.8],
          [9.2, 4.6],
          [14.8, 4.6],
          [14.8, 6.8],
        ]);
        path([
          [6.5, 6.8],
          [7.4, 19.6],
          [16.6, 19.6],
          [17.5, 6.8],
        ]);
        line(10.4, 10.2, 10.8, 16.4);
        line(13.6, 10.2, 13.2, 16.4);
        break;

      case AppIconData.note:
        path([
          [5, 3.8],
          [14.5, 3.8],
          [19, 8.3],
          [19, 20.2],
          [5, 20.2],
        ], close: true);
        path([
          [14.5, 3.8],
          [14.5, 8.3],
          [19, 8.3],
        ]);
        line(8.5, 12.6, 15.5, 12.6);
        line(8.5, 16, 13.5, 16);
        break;

      case AppIconData.phone:
        path([
          [7.2, 4],
          [5.2, 4],
          [4, 5.4],
          [4.6, 10.4],
          [9.6, 15.4],
          [14.6, 16],
          [16, 14.8],
          [16, 12.8],
          [13.6, 11.8],
          [11.8, 13.2],
          [9, 10.4],
          [10.4, 8.6],
          [8.2, 6.2],
        ], close: true);
        break;

      case AppIconData.sparkle:
        path([
          [12, 3.5],
          [13.4, 9.3],
          [19.5, 12],
          [13.4, 14.7],
          [12, 20.5],
          [10.6, 14.7],
          [4.5, 12],
          [10.6, 9.3],
        ], close: true);
        break;

      case AppIconData.clock:
        circle(12, 12, 8.4);
        line(12, 7.4, 12, 12);
        line(12, 12, 15.6, 13.8);
        break;

      case AppIconData.wallet:
        _roundedRect(canvas, s, 3.5, 6, 17, 13.5, 2.5, stroke);
        path([
          [3.5, 10],
          [20.5, 10],
        ]);
        circle(17, 14.6, 1.1, filled: true);
        break;

      case AppIconData.gift:
        _roundedRect(canvas, s, 4, 9.5, 16, 11.3, 1.5, stroke);
        line(3, 9.5, 21, 9.5);
        line(12, 9.5, 12, 20.8);
        path([
          [12, 9.5],
          [9.2, 6.4],
          [9.6, 4.2],
          [11.4, 4.2],
          [12, 6.4],
        ]);
        path([
          [12, 9.5],
          [14.8, 6.4],
          [14.4, 4.2],
          [12.6, 4.2],
          [12, 6.4],
        ]);
        break;

      case AppIconData.calendar:
        _roundedRect(canvas, s, 4, 5.5, 16, 15, 2.5, stroke);
        line(4, 10, 20, 10);
        line(8.5, 3.5, 8.5, 7);
        line(15.5, 3.5, 15.5, 7);
        circle(9, 14, 1.1, filled: true);
        circle(15, 14, 1.1, filled: true);
        circle(9, 17.4, 1.1, filled: true);
        break;

      case AppIconData.arrowLeft:
        line(19, 12, 5.5, 12);
        path([
          [11, 5.5],
          [4.5, 12],
          [11, 18.5],
        ]);
        break;

      case AppIconData.refresh:
        final arc = Path()
          ..addArc(
            Rect.fromCircle(center: p(12, 12), radius: 8.2 * s),
            -math.pi * 0.35,
            math.pi * 1.55,
          );
        canvas.drawPath(arc, stroke);
        path([
          [17.4, 4.4],
          [18.6, 9.2],
          [13.7, 8.2],
        ]);
        break;

      case AppIconData.layers:
        path([
          [12, 3.6],
          [20.5, 8],
          [12, 12.4],
          [3.5, 8],
        ], close: true);
        path([
          [3.5, 12.4],
          [12, 16.8],
          [20.5, 12.4],
        ]);
        path([
          [3.5, 16.2],
          [12, 20.4],
          [20.5, 16.2],
        ]);
        break;

      case AppIconData.filter:
        line(3.6, 6, 20.4, 6);
        line(6.4, 12, 17.6, 12);
        line(9.6, 18, 14.4, 18);
        break;

      case AppIconData.send:
        path([
          [20.5, 3.8],
          [3.5, 10.6],
          [10.4, 12.9],
          [12.7, 19.8],
          [20.5, 3.8],
        ], close: true);
        line(10.4, 12.9, 20.5, 3.8);
        break;
    }
  }

  void _roundedRect(Canvas canvas, double s, double x, double y, double w,
      double h, double r, Paint paint) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x * s, y * s, w * s, h * s),
        Radius.circular(r * s),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(_AppIconPainter old) =>
      old.icon != icon || old.color != color || old.strokeWidth != strokeWidth;
}
