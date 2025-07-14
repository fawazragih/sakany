import 'package:flutter/material.dart';

class DashedDividerWidget extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  const DashedDividerWidget({
    super.key,
    this.margin,
    this.color,
    this.strokeWidth = 1,
    this.dashWidth = 4,
    this.dashSpace = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.symmetric(vertical: 8.0),
      child: CustomPaint(
        painter: DashedLinePainter(
          color: color ?? Theme.of(context).dividerColor,
          strokeWidth: strokeWidth,
          dashSpace: dashSpace,
          dashWidth: dashWidth,
        ),
        child: Container(),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedLinePainter({
    required this.color,
    this.strokeWidth = 1,
    this.dashWidth = 4,
    this.dashSpace = 5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double startX = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
