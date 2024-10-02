import 'package:flutter/material.dart';

class DottedVerticalDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double strokeWidth;
  final double spacing;

  DottedVerticalDivider({
    required this.height,
    required this.color,
    this.strokeWidth = 1.0,
    this.spacing = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: CustomPaint(
        painter: _DottedLinePainter(
          color: color,
          strokeWidth: strokeWidth,
          spacing: spacing,
        ),
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

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(_DottedLinePainter oldDelegate) {
    return color != oldDelegate.color ||
        strokeWidth != oldDelegate.strokeWidth ||
        spacing != oldDelegate.spacing;
  }
}
