import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/metaskill_detailed.dart';
import '../theme/app_theme.dart';

class MetaskillDetailModal extends StatelessWidget {
  final MetaskillDetailed skill;

  const MetaskillDetailModal({
    super.key,
    required this.skill,
  });

  static void show(BuildContext context, MetaskillDetailed skill) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MetaskillDetailModal(skill: skill),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A1F3A), AppColors.background],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with emoji and domain
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: skill.domain.color.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            skill.emoji,
                            style: const TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              skill.title,
                              style: AppTextStyles.h2,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  skill.domain.emoji,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  skill.domain.title,
                                  style: AppTextStyles.caption.copyWith(
                                    color: skill.domain.color,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).animate().fadeIn().slideX(begin: -0.2, end: 0),

                  const SizedBox(height: 24),

                  // Current level
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: AppDecorations.cardBackground,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Текущий уровень',
                              style: AppTextStyles.body,
                            ),
                            Text(
                              '${skill.currentLevel.toInt()}/100',
                              style: AppTextStyles.h3.copyWith(
                                color: skill.domain.color,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: skill.currentLevel / 100,
                            backgroundColor: Colors.white.withOpacity(0.1),
                            valueColor: AlwaysStoppedAnimation(skill.domain.color),
                            minHeight: 12,
                          ),
                        ),
                      ],
                    ),
                  ).animate(delay: 100.ms).fadeIn().slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 20),

                  // Description
                  Text(
                    'Что это такое?',
                    style: AppTextStyles.h3,
                  ).animate(delay: 200.ms).fadeIn(),

                  const SizedBox(height: 8),

                  Text(
                    skill.description,
                    style: AppTextStyles.body.copyWith(height: 1.6),
                  ).animate(delay: 250.ms).fadeIn(),

                  const SizedBox(height: 24),

                  // Quick tip
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: skill.domain.color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: skill.domain.color.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '💡',
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Быстрый совет',
                                style: AppTextStyles.caption.copyWith(
                                  color: skill.domain.color,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                skill.shortTip,
                                style: AppTextStyles.body,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).animate(delay: 300.ms).fadeIn().scale(begin: const Offset(0.9, 0.9)),

                  const SizedBox(height: 24),

                  // How to improve
                  Text(
                    'Как прокачать?',
                    style: AppTextStyles.h3,
                  ).animate(delay: 350.ms).fadeIn(),

                  const SizedBox(height: 12),

                  ...skill.howToImprove.asMap().entries.map((entry) {
                    final index = entry.key;
                    final tip = entry.value;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: AppDecorations.cardBackground,
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: skill.domain.color.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: skill.domain.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              tip,
                              style: AppTextStyles.body,
                            ),
                          ),
                        ],
                      ),
                    ).animate(delay: (400 + index * 50).ms).fadeIn().slideX(begin: -0.2, end: 0);
                  }).toList(),

                  const SizedBox(height: 24),

                  // CTA button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: Navigate to relevant practice
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: skill.domain.color,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Начать тренировку',
                        style: AppTextStyles.h3.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ).animate(delay: 600.ms).fadeIn().slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
