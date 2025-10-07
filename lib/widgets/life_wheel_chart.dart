import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/life_sphere.dart';
import 'life_sphere_detail_modal.dart';

class LifeWheelChart extends StatelessWidget {
  final LifeWheelBalance balance;
  final double size;
  final Function(LifeSphereData)? onSectorTap;

  const LifeWheelChart({
    super.key,
    required this.balance,
    this.size = 300,
    this.onSectorTap,
  });

  void _handleTap(BuildContext context, Offset localPosition) {
    final center = Offset(size / 2, size / 2);
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;

    // Check if tap is outside center circle (radius > 50)
    final distance = math.sqrt(dx * dx + dy * dy);
    if (distance < 50) return;

    // Calculate angle
    var angle = math.atan2(dy, dx);
    // Adjust to start from top (-π/2)
    angle = angle + math.pi / 2;
    if (angle < 0) angle += 2 * math.pi;

    // Determine which sector was tapped
    final angleStep = (2 * math.pi) / balance.spheres.length;
    final tappedIndex = (angle / angleStep).floor() % balance.spheres.length;

    final tappedSphere = balance.spheres[tappedIndex];

    if (onSectorTap != null) {
      onSectorTap!(tappedSphere);
    } else {
      // Default behavior: show modal
      LifeSphereDetailModal.show(
        context,
        tappedSphere.sphere,
        tappedSphere.value.toDouble(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        _handleTap(context, details.localPosition);
      },
      child: SizedBox(
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

    // Draw labels with emoji and value
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    for (var i = 0; i < spheres.length; i++) {
      final angle = -math.pi / 2 + (angleStep * i);
      final labelRadius = radius + 35;
      final labelPoint = Offset(
        center.dx + labelRadius * math.cos(angle),
        center.dy + labelRadius * math.sin(angle),
      );

      // Draw emoji
      textPainter.text = TextSpan(
        text: spheres[i].sphere.emoji,
        style: const TextStyle(fontSize: 24),
      );
      textPainter.layout();

      var offset = Offset(
        labelPoint.dx - textPainter.width / 2,
        labelPoint.dy - textPainter.height / 2 - 8,
      );

      textPainter.paint(canvas, offset);

      // Draw value below emoji
      textPainter.text = TextSpan(
        text: '${spheres[i].value.toInt()}',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: spheres[i].sphere.color,
        ),
      );
      textPainter.layout();

      offset = Offset(
        labelPoint.dx - textPainter.width / 2,
        labelPoint.dy + 8,
      );

      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(_LifeWheelPainter oldDelegate) {
    return oldDelegate.balance != balance;
  }
}
