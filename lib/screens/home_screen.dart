import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../models/user_model.dart';
import '../models/metaskill.dart';
import '../widgets/metaskills_radar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock user data
    final user = User(
      name: 'Александр',
      mycTokens: 1250,
      streak: 12,
      level: 5,
      position: 27,
      levelProgress: 0.65,
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.background, Color(0xFF1A1F3A)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with greeting and balance
                Text(
                  'Привет, ${user.name}! 👋',
                  style: AppTextStyles.h1,
                ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2, end: 0),

                const SizedBox(height: 20),

                // Balance and streak card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: AppDecorations.gradientCard(
                    AppGradients.primaryGradient,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'MYC Токены',
                              style: AppTextStyles.caption,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${user.mycTokens}',
                              style: AppTextStyles.h1.copyWith(fontSize: 36),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              '🔥',
                              style: TextStyle(fontSize: 24),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${user.streak}',
                              style: AppTextStyles.h2.copyWith(fontSize: 20),
                            ),
                            const Text(
                              'дней',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 100.ms).slideX(begin: 0.2, end: 0),

                const SizedBox(height: 30),

                // Today's tasks section
                const Text(
                  'Сегодня',
                  style: AppTextStyles.h2,
                ).animate().fadeIn(delay: 200.ms),

                const SizedBox(height: 16),

                _buildTaskCard(
                  '✅ Пройти тест MBTI',
                  'Завершено',
                  isCompleted: true,
                ),
                _buildTaskCard(
                  '🎯 Встреча с AI ментором',
                  '14:00',
                  isCompleted: false,
                ),
                _buildTaskCard(
                  '🎲 Попробовать P2P рулетку',
                  'Рекомендуем',
                  isCompleted: false,
                  isRecommended: true,
                ),

                const SizedBox(height: 30),

                // Level progress
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
                            'Уровень ${user.level}',
                            style: AppTextStyles.h3,
                          ),
                          Text(
                            '${(user.levelProgress * 100).toInt()}%',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: user.levelProgress,
                          minHeight: 8,
                          backgroundColor: AppColors.textSecondary.withOpacity(0.2),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.success,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '450 MYC до следующего уровня',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 400.ms),

                const SizedBox(height: 30),

                // Metaskills radar chart
                MetaskillsRadar(
                  domainScores: {
                    MetaskillDomain.cognitive: 0.75,
                    MetaskillDomain.social: 0.65,
                    MetaskillDomain.emotional: 0.82,
                    MetaskillDomain.practical: 0.58,
                  },
                ).animate().fadeIn(delay: 500.ms),

                const SizedBox(height: 30),

                // Recommendation card with shimmer
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: AppDecorations.gradientCard(
                    AppGradients.purpleGradient,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Рекомендация дня',
                            style: AppTextStyles.h3,
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Попробуйте новый AI ментор - Карл Юнг поможет разобраться с вашими снами и подсознанием',
                        style: AppTextStyles.body,
                      ),
                    ],
                  ),
                )
                    .animate(
                      onPlay: (controller) => controller.repeat(),
                    )
                    .shimmer(
                      duration: 2000.ms,
                      color: Colors.white.withOpacity(0.3),
                    ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskCard(String title, String subtitle,
      {required bool isCompleted, bool isRecommended = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: AppDecorations.cardBackground,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppColors.success.withOpacity(0.2)
                  : isRecommended
                      ? AppColors.warning.withOpacity(0.2)
                      : AppColors.textSecondary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCompleted ? Icons.check : Icons.circle_outlined,
              color: isCompleted
                  ? AppColors.success
                  : isRecommended
                      ? AppColors.warning
                      : AppColors.textSecondary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: isCompleted
                      ? AppTextStyles.body.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: AppColors.textSecondary,
                        )
                      : AppTextStyles.body,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.2, end: 0);
  }
}
