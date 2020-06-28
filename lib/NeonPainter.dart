import 'package:flutter/material.dart';


class NeonPainter extends CustomPainter {
  Paint neonPaint = Paint();


  NeonPainter() {
    neonPaint.color = const Color(0xFF3F5BFA);
    neonPaint.strokeWidth = 2.5;


  }

  @override
  void paint(Canvas canvas, Size size) {
    drawLine(canvas, size.width / 2 - 50, size.height / 2, size.width / 2 + 50,
        size.height / 2);
    drawLine(canvas, size.width / 2 + 50, size.height / 2, size.width / 2 + 100,
        size.height / 2 + 50);
    drawLine(canvas, size.width / 2 + 100, size.height / 2 + 50,
        size.width / 2 - 100, size.height / 2 + 50);
    drawLine(
        canvas, size.width / 2 - 100, size.height / 2 + 50, size.width / 2 - 50,
        size.height / 2);
  }

  void drawLine(canvas, double x1, double y1, double x2, double y2) {
    canvas.drawLine(Offset(x1, y1), Offset(x2, y2), neonPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}