import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../models/user_model.dart';
import '../models/level_system.dart';
import '../models/metaskill_detailed.dart';
import '../models/achievement.dart';
import '../models/life_sphere.dart';
import '../widgets/metaskills_radar_16.dart';
import '../widgets/metaskill_detail_modal.dart';
import '../widgets/life_wheel_chart.dart';
import '../widgets/achievement_detail_modal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock user data
    final user = User(
      id: 'mock-user-id',
      telegramId: 123456789,
      firstName: 'Габил',
      username: 'gabil',
      mycTokens: 1250,
      streakDays: 12,
      level: 28,
      levelProgress: 0.65,
      xp: 580,
      trustScore: 87.5,
      stats: UserStats(
        testsCompleted: 12,
        p2pCalls: 8,
        achievements: 4,
      ),
    );

    final userLevel = UserLevel.fromXP(user.xp);
    final all16Skills = MetaskillDetailed.getAll16Skills();
    final achievements = Achievement.getInitialAchievements();
    final unlockedAchievements = achievements.take(4).toList();
    final lifeWheel = LifeWheelBalance.fromMockData();

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
                // Compact header card (MYC + Level + Trust Score)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: AppDecorations.gradientCard(
                    AppGradients.primaryGradient,
                  ),
                  child: Row(
                    children: [
                      // MYC Tokens
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'MYC',
                              style: AppTextStyles.caption,
                            ),
                            Text(
                              '${user.mycTokens}',
                              style: AppTextStyles.h2.copyWith(fontSize: 24),
                            ),
                          ],
                        ),
                      ),

                      // Level
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Text(
                              userLevel.tier.emoji,
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Ур. ${user.level}',
                              style: AppTextStyles.body.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Trust Score
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Text(
                              '🛡️',
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${user.trustScore.toInt()}',
                              style: AppTextStyles.body.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Streak
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Text(
                              '🔥',
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${user.streakDays}',
                              style: AppTextStyles.body.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn().slideY(begin: -0.2, end: 0),

                const SizedBox(height: 24),

                // Tasks section
                Text(
                  'Задания',
                  style: AppTextStyles.h2,
                ).animate(delay: 100.ms).fadeIn(),

                const SizedBox(height: 12),

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

                const SizedBox(height: 24),

                // Achievements compact
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Достижения',
                      style: AppTextStyles.h3,
                    ),
                    Text(
                      '${unlockedAchievements.length}/${achievements.length}',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.warning,
                      ),
                    ),
                  ],
                ).animate(delay: 300.ms).fadeIn(),

                const SizedBox(height: 12),

                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: unlockedAchievements.length,
                    itemBuilder: (context, index) {
                      final achievement = unlockedAchievements[index];
                      return GestureDetector(
                        onTap: () => AchievementDetailModal.show(
                          context,
                          achievement.copyWith(isUnlocked: true),
                        ),
                        child: Container(
                          width: 70,
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primaryPurple.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.primaryPurple,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                achievement.emoji,
                                style: const TextStyle(fontSize: 28),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                achievement.title,
                                style: AppTextStyles.caption.copyWith(fontSize: 9),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ).animate(delay: (350 + index * 50).ms).fadeIn().scale(),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 30),

                // Life Wheel (moved above metaskills)
                Text(
                  'Колесо баланса',
                  style: AppTextStyles.h2,
                ).animate(delay: 500.ms).fadeIn(),

                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: AppDecorations.cardBackground,
                  child: Column(
                    children: [
                      LifeWheelChart(balance: lifeWheel, size: 280),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem(
                            'Средний балл',
                            '${lifeWheel.averageBalance.toInt()}',
                          ),
                          _buildStatItem(
                            'Гармония',
                            '${(lifeWheel.harmony * 100).toInt()}%',
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate(delay: 550.ms).fadeIn().scale(begin: const Offset(0.9, 0.9)),

                const SizedBox(height: 30),

                // 16 Metaskills Radar
                Text(
                  '16 Метанавыков',
                  style: AppTextStyles.h2,
                ).animate(delay: 600.ms).fadeIn(),

                const SizedBox(height: 16),

                Center(
                  child: MetaskillsRadar16(
                    skills: all16Skills,
                    size: 340,
                    onSkillTap: (skill) {
                      MetaskillDetailModal.show(context, skill);
                    },
                  ),
                ).animate(delay: 650.ms).fadeIn().scale(begin: const Offset(0.9, 0.9)),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskCard(
    String title,
    String subtitle, {
    required bool isCompleted,
    bool isRecommended = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: AppDecorations.cardBackground,
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
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
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
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
                          fontSize: 14,
                        )
                      : AppTextStyles.body.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.caption.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate(delay: 250.ms).fadeIn().slideX(begin: -0.2, end: 0);
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.h2.copyWith(fontSize: 22)),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}
