import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/metaskill_detailed.dart';
import '../theme/app_theme.dart';

class MetaskillsRadar16 extends StatefulWidget {
  final List<MetaskillDetailed> skills;
  final double size;
  final Function(MetaskillDetailed)? onSkillTap;

  const MetaskillsRadar16({
    super.key,
    required this.skills,
    this.size = 320,
    this.onSkillTap,
  });

  @override
  State<MetaskillsRadar16> createState() => _MetaskillsRadar16State();
}

class _MetaskillsRadar16State extends State<MetaskillsRadar16> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) => _handleTap(details.localPosition),
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: _MetaskillsRadar16Painter(
          skills: widget.skills,
          hoveredIndex: hoveredIndex,
        ),
      ),
    );
  }

  void _handleTap(Offset localPosition) {
    final center = Offset(widget.size / 2, widget.size / 2);
    final radius = widget.size / 2 - 60;

    // Convert tap position to polar coordinates
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;
    final distance = math.sqrt(dx * dx + dy * dy);

    if (distance > radius * 0.3) { // Only trigger if outside center
      var angle = math.atan2(dy, dx);
      if (angle < 0) angle += 2 * math.pi;

      // Adjust for starting angle (-90 degrees = -pi/2)
      angle += math.pi / 2;
      if (angle >= 2 * math.pi) angle -= 2 * math.pi;

      // Determine which skill sector was tapped
      final anglePerSkill = 2 * math.pi / widget.skills.length;
      final tappedIndex = (angle / anglePerSkill).floor() % widget.skills.length;

      if (widget.onSkillTap != null) {
        widget.onSkillTap!(widget.skills[tappedIndex]);
      }

      setState(() {
        hoveredIndex = tappedIndex;
      });

      // Reset hover after animation
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() {
            hoveredIndex = null;
          });
        }
      });
    }
  }
}

class _MetaskillsRadar16Painter extends CustomPainter {
  final List<MetaskillDetailed> skills;
  final int? hoveredIndex;

  _MetaskillsRadar16Painter({
    required this.skills,
    this.hoveredIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 60;
    final angleStep = 2 * math.pi / skills.length;

    // Draw background grid circles
    _drawGridCircles(canvas, center, radius);

    // Draw axis lines and labels
    for (int i = 0; i < skills.length; i++) {
      _drawAxis(canvas, center, radius, i, angleStep);
    }

    // Draw data polygon
    _drawDataPolygon(canvas, center, radius, angleStep);

    // Draw skill points
    for (int i = 0; i < skills.length; i++) {
      _drawSkillPoint(canvas, center, radius, i, angleStep);
    }
  }

  void _drawGridCircles(Canvas canvas, Offset center, double radius) {
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 1; i <= 5; i++) {
      canvas.drawCircle(center, radius * i / 5, gridPaint);
    }
  }

  void _drawAxis(Canvas canvas, Offset center, double radius, int index, double angleStep) {
    final angle = -math.pi / 2 + index * angleStep; // Start from top
    final end = Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );

    // Draw axis line
    final axisPaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..strokeWidth = 1;
    canvas.drawLine(center, end, axisPaint);

    // Draw label
    final skill = skills[index];
    final labelRadius = radius + 30;
    final labelX = center.dx + labelRadius * math.cos(angle);
    final labelY = center.dy + labelRadius * math.sin(angle);

    final textSpan = TextSpan(
      text: skill.emoji,
      style: TextStyle(
        fontSize: hoveredIndex == index ? 20 : 16,
        color: hoveredIndex == index
          ? skill.domain.color
          : Colors.white.withOpacity(0.8),
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(labelX - textPainter.width / 2, labelY - textPainter.height / 2),
    );
  }

  void _drawDataPolygon(Canvas canvas, Offset center, double radius, double angleStep) {
    final path = Path();

    for (int i = 0; i < skills.length; i++) {
      final angle = -math.pi / 2 + i * angleStep;
      final value = skills[i].currentLevel / 100;
      final pointRadius = radius * value;

      final x = center.dx + pointRadius * math.cos(angle);
      final y = center.dy + pointRadius * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    // Fill with gradient
    final fillPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.primaryPurple.withOpacity(0.4),
          AppColors.primaryBlue.withOpacity(0.2),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, fillPaint);

    // Draw outline
    final strokePaint = Paint()
      ..color = AppColors.primaryPurple
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    canvas.drawPath(path, strokePaint);
  }

  void _drawSkillPoint(Canvas canvas, Offset center, double radius, int index, double angleStep) {
    final skill = skills[index];
    final angle = -math.pi / 2 + index * angleStep;
    final value = skill.currentLevel / 100;
    final pointRadius = radius * value;

    final x = center.dx + pointRadius * math.cos(angle);
    final y = center.dy + pointRadius * math.sin(angle);
    final point = Offset(x, y);

    final isHovered = hoveredIndex == index;

    // Draw point
    final pointPaint = Paint()
      ..color = isHovered ? skill.domain.color : Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(point, isHovered ? 8 : 5, pointPaint);

    // Draw border
    final borderPaint = Paint()
      ..color = skill.domain.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = isHovered ? 3 : 2;

    canvas.drawCircle(point, isHovered ? 8 : 5, borderPaint);

    // Draw pulse effect on hover
    if (isHovered) {
      final pulsePaint = Paint()
        ..color = skill.domain.color.withOpacity(0.3)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(point, 14, pulsePaint);
    }
  }

  @override
  bool shouldRepaint(_MetaskillsRadar16Painter oldDelegate) {
    return oldDelegate.hoveredIndex != hoveredIndex ||
           oldDelegate.skills != skills;
  }
}
