import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
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
              child: RadarChart(
                RadarChartData(
                  radarTouchData: RadarTouchData(enabled: true),
                  dataSets: [
                    RadarDataSet(
                      fillColor: AppColors.primaryPurple.withOpacity(0.2),
                      borderColor: AppColors.primaryPurple,
                      borderWidth: 2,
                      dataEntries: MetaskillDomain.values.map((domain) {
                        return RadarEntry(value: (domainScores[domain] ?? 0.5) * 100);
                      }).toList(),
                    ),
                  ],
                  radarBackgroundColor: Colors.transparent,
                  radarBorderData: BorderSide(
                    color: AppColors.textSecondary.withOpacity(0.2),
                    width: 1,
                  ),
                  titlePositionPercentageOffset: 0.15,
                  titleTextStyle: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                  getTitle: (index, angle) {
                    final domain = MetaskillDomain.values[index];
                    return RadarChartTitle(
                      text: domain.emoji,
                      angle: 0,
                    );
                  },
                  tickCount: 4,
                  ticksTextStyle: const TextStyle(
                    color: Colors.transparent,
                    fontSize: 0,
                  ),
                  tickBorderData: BorderSide(
                    color: AppColors.textSecondary.withOpacity(0.1),
                    width: 1,
                  ),
                  gridBorderData: BorderSide(
                    color: AppColors.textSecondary.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                swapAnimationDuration: const Duration(milliseconds: 800),
                swapAnimationCurve: Curves.easeInOutCubic,
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
