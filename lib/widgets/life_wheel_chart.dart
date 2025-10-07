import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/life_sphere.dart';

class LifeWheelChart extends StatelessWidget {
  final LifeWheelBalance balance;
  final double size;

  const LifeWheelChart({
    super.key,
    required this.balance,
    this.size = 300,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _LifeWheelPainter(balance),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${balance.averageBalance.toInt()}',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Средний балл',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LifeWheelPainter extends CustomPainter {
  final LifeWheelBalance balance;

  _LifeWheelPainter(this.balance);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 40;
    final spheres = balance.spheres;
    final angleStep = (2 * math.pi) / spheres.length;

    // Draw grid lines
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (var i = 1; i <= 4; i++) {
      canvas.drawCircle(center, radius * (i / 4), gridPaint);
    }

    // Draw axes
    for (var i = 0; i < spheres.length; i++) {
      final angle = -math.pi / 2 + (angleStep * i);
      final endPoint = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(center, endPoint, gridPaint);
    }

    // Draw data polygon
    final path = Path();
    final dataPoints = <Offset>[];

    for (var i = 0; i < spheres.length; i++) {
      final angle = -math.pi / 2 + (angleStep * i);
      final value = spheres[i].value / 100;
      final point = Offset(
        center.dx + radius * value * math.cos(angle),
        center.dy + radius * value * math.sin(angle),
      );
      dataPoints.add(point);

      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();

    // Fill polygon with gradient
    final fillPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF6366F1).withOpacity(0.6),
          const Color(0xFF8B5CF6).withOpacity(0.3),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, fillPaint);

    // Draw border
    final borderPaint = Paint()
      ..color = const Color(0xFF6366F1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(path, borderPaint);

    // Draw points
    for (var i = 0; i < dataPoints.length; i++) {
      final pointPaint = Paint()
        ..color = spheres[i].sphere.color
        ..style = PaintingStyle.fill;

      canvas.drawCircle(dataPoints[i], 6, pointPaint);

      canvas.drawCircle(
        dataPoints[i],
        6,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }

    // Draw labels
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (var i = 0; i < spheres.length; i++) {
      final angle = -math.pi / 2 + (angleStep * i);
      final labelRadius = radius + 30;
      final labelPoint = Offset(
        center.dx + labelRadius * math.cos(angle),
        center.dy + labelRadius * math.sin(angle),
      );

      textPainter.text = TextSpan(
        text: spheres[i].sphere.emoji,
        style: const TextStyle(fontSize: 20),
      );
      textPainter.layout();

      final offset = Offset(
        labelPoint.dx - textPainter.width / 2,
        labelPoint.dy - textPainter.height / 2,
      );

      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(_LifeWheelPainter oldDelegate) {
    return oldDelegate.balance != balance;
  }
}
