import 'dart:ui';

import 'package:flutter/material.dart';

class FacePainter extends CustomPainter {
  final List<Offset> points;
  const FacePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final pointsFix = points.map((e) => Offset(e.dx / 10, e.dy / 10)).toList();

    canvas.drawPoints(PointMode.polygon, pointsFix, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
