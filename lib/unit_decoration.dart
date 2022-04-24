import 'dart:ui';

import 'package:flutter/material.dart';

class UnitDecoration extends Decoration {
  final Color color;
  const UnitDecoration({required this.color});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      _UnitDecorationPainter(color: color);
}

class _UnitDecorationPainter extends BoxPainter {
  final Color color;
  const _UnitDecorationPainter({required this.color});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final size = configuration.size!;
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..strokeWidth = 1;
    final points = [
      const Offset(0, 0),
      Offset(size.width, 0),
      Offset(size.width, size.height),
      Offset(0, size.height),
    ];
    canvas.drawColor(color, BlendMode.src);
    canvas.drawPoints(PointMode.points, points, paint);
  }
}
