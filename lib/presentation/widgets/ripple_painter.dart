import 'package:flutter/material.dart';

class RipplePainter extends CustomPainter {
  final double radius;
  final double? strokeWidth;
  final Paint _paint;

  RipplePainter(this.radius, {this.strokeWidth})
      : _paint = Paint()
    ..color = Colors.white.withValues(alpha: 0.9)
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth ?? 5;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, _paint);
  }

  @override
  bool shouldRepaint(RipplePainter oldDelegate) {
    return oldDelegate.radius != radius ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}