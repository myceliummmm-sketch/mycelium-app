import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/metaskill.dart';

class MetaskillsRadar extends StatelessWidget {
  final Map<MetaskillDomain, double> domainScores;

  const MetaskillsRadar({
    super.key,
    required this.domainScores,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppDecorations.cardBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Профиль метаскилов',
            style: AppTextStyles.h3,
          ),
          const SizedBox(height: 8),
          const Text(
            'Ваши сильные стороны по 4 доменам',
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: 24),
          Center(
            child: SizedBox(
              width: 280,
              height: 280,
              child: CustomPaint(
                painter: RadarChartPainter(domainScores),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Column(
      children: MetaskillDomain.values.map((domain) {
        final score = domainScores[domain] ?? 0.5;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: _getColorForDomain(domain),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${domain.emoji} ${domain.title}',
                      style: AppTextStyles.body,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getColorForDomain(domain).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${(score * 100).toInt()}%',
                  style: AppTextStyles.caption.copyWith(
                    color: _getColorForDomain(domain),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Color _getColorForDomain(MetaskillDomain domain) {
    switch (domain) {
      case MetaskillDomain.cognitive:
        return AppColors.primaryPurple;
      case MetaskillDomain.social:
        return AppColors.primaryBlue;
      case MetaskillDomain.emotional:
        return AppColors.warning;
      case MetaskillDomain.practical:
        return AppColors.success;
    }
  }
}

class RadarChartPainter extends CustomPainter {
  final Map<MetaskillDomain, double> domainScores;

  RadarChartPainter(this.domainScores);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20;
    final domains = MetaskillDomain.values;

    // Draw background circles
    _drawBackgroundCircles(canvas, center, radius);

    // Draw axes
    _drawAxes(canvas, center, radius, domains);

    // Draw data polygon
    _drawDataPolygon(canvas, center, radius, domains);

    // Draw labels
    _drawLabels(canvas, center, radius, domains);
  }

  void _drawBackgroundCircles(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = AppColors.textSecondary.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 1; i <= 4; i++) {
      canvas.drawCircle(center, radius * (i / 4), paint);
    }
  }

  void _drawAxes(
      Canvas canvas, Offset center, double radius, List<MetaskillDomain> domains) {
    final paint = Paint()
      ..color = AppColors.textSecondary.withOpacity(0.2)
      ..strokeWidth = 1;

    for (int i = 0; i < domains.length; i++) {
      final angle = (i * 2 * math.pi / domains.length) - math.pi / 2;
      final end = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(center, end, paint);
    }
  }

  void _drawDataPolygon(
      Canvas canvas, Offset center, double radius, List<MetaskillDomain> domains) {
    final path = Path();
    final points = <Offset>[];

    for (int i = 0; i < domains.length; i++) {
      final score = domainScores[domains[i]] ?? 0.5;
      final angle = (i * 2 * math.pi / domains.length) - math.pi / 2;
      final distance = radius * score;

      final point = Offset(
        center.dx + distance * math.cos(angle),
        center.dy + distance * math.sin(angle),
      );
      points.add(point);

      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();

    // Fill
    final fillPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.primaryPurple.withOpacity(0.3),
          AppColors.primaryBlue.withOpacity(0.2),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // Stroke
    final strokePaint = Paint()
      ..color = AppColors.primaryPurple
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(path, strokePaint);

    // Draw points
    for (int i = 0; i < points.length; i++) {
      final pointPaint = Paint()
        ..color = _getColorForDomainByIndex(i)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(points[i], 5, pointPaint);

      // White border
      final borderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawCircle(points[i], 5, borderPaint);
    }
  }

  void _drawLabels(
      Canvas canvas, Offset center, double radius, List<MetaskillDomain> domains) {
    for (int i = 0; i < domains.length; i++) {
      final angle = (i * 2 * math.pi / domains.length) - math.pi / 2;
      final labelRadius = radius + 30;

      final labelPos = Offset(
        center.dx + labelRadius * math.cos(angle),
        center.dy + labelRadius * math.sin(angle),
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: domains[i].emoji,
          style: const TextStyle(fontSize: 24),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          labelPos.dx - textPainter.width / 2,
          labelPos.dy - textPainter.height / 2,
        ),
      );
    }
  }

  Color _getColorForDomainByIndex(int index) {
    final domain = MetaskillDomain.values[index];
    switch (domain) {
      case MetaskillDomain.cognitive:
        return AppColors.primaryPurple;
      case MetaskillDomain.social:
        return AppColors.primaryBlue;
      case MetaskillDomain.emotional:
        return AppColors.warning;
      case MetaskillDomain.practical:
        return AppColors.success;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
