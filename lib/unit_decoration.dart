import 'dart:ui';

import 'package:flutter/material.dart';

class UnitDecoration extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      _UnitDecorationPainter();
}

class _UnitDecorationPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    _drawCornerMarks(canvas, configuration.size!);
  }

  void _drawCornerMarks(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..strokeWidth = 1;
    final points = [
      const Offset(0, 0),
      Offset(size.width, 0),
      Offset(size.width, size.height),
      Offset(0, size.height),
    ];
    canvas.drawPoints(PointMode.points, points, paint);
  }
}
