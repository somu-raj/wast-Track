import 'package:flutter/material.dart';

class DottedHorizontalDivider extends StatelessWidget {
  final double width;
  final Color color;
  final double strokeWidth;
  final double spacing;

  DottedHorizontalDivider({
    required this.width,
    required this.color,
    this.strokeWidth = 1.0,
    this.spacing = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, strokeWidth),
      painter: _DottedLinePainter(
        color: color,
        strokeWidth: strokeWidth,
        spacing: spacing,
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double spacing;

  _DottedLinePainter({
    required this.color,
    required this.strokeWidth,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double dashWidth = 4;
    final double dashSpace = spacing;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(_DottedLinePainter oldDelegate) {
    return color != oldDelegate.color ||
        strokeWidth != oldDelegate.strokeWidth ||
        spacing != oldDelegate.spacing;
  }
}
