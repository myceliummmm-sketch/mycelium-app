import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../models/user_model.dart';
import '../models/level_system.dart';
import '../models/achievement.dart';
import '../models/life_sphere.dart';
import '../widgets/life_wheel_chart.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock user with new fields
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
    final achievements = Achievement.getInitialAchievements();
    final unlockedAchievements = achievements.take(4).map((a) =>
      a.copyWith(isUnlocked: true)).toList();
    final lockedAchievements = achievements.skip(4).toList();
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
                // Header
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        user.firstName?.substring(0, 1).toUpperCase() ?? 'U',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.displayName,
                            style: AppTextStyles.h2,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '@${user.username}',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                  ],
                ).animate().fadeIn().slideX(begin: -0.2, end: 0),

                const SizedBox(height: 24),

                // Level & Trust Score Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: AppDecorations.gradientCard(AppGradients.primaryGradient),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      userLevel.tier.emoji,
                                      style: const TextStyle(fontSize: 28),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      userLevel.tier.title,
                                      style: AppTextStyles.h3,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Уровень ${userLevel.currentLevel}',
                                  style: AppTextStyles.caption,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${user.xp} XP',
                                  style: AppTextStyles.body.copyWith(
                                    color: AppColors.warning,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                                  '🛡️',
                                  style: TextStyle(fontSize: 32),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${user.trustScore.toInt()}',
                                  style: AppTextStyles.h2.copyWith(fontSize: 24),
                                ),
                                const Text(
                                  'Trust',
                                  style: AppTextStyles.caption,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: userLevel.progress,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          valueColor: const AlwaysStoppedAnimation(AppColors.warning),
                          minHeight: 8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${userLevel.xpToNextLevel - user.xp} XP до следующего уровня',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ).animate(delay: 100.ms).fadeIn().slideY(begin: 0.2, end: 0),

                const SizedBox(height: 24),

                // Privileges
                Text(
                  'Привилегии уровня',
                  style: AppTextStyles.h3,
                ).animate(delay: 200.ms).fadeIn(),

                const SizedBox(height: 12),

                ...userLevel.tier.privileges.asMap().entries.map((entry) {
                  final index = entry.key;
                  final privilege = entry.value;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: AppDecorations.cardBackground,
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, color: AppColors.success, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(privilege, style: AppTextStyles.body),
                        ),
                      ],
                    ),
                  ).animate(delay: (200 + index * 50).ms).fadeIn();
                }).toList(),

                const SizedBox(height: 24),

                // Achievements
                Text(
                  'Достижения (${unlockedAchievements.length}/${achievements.length})',
                  style: AppTextStyles.h3,
                ).animate(delay: 400.ms).fadeIn(),

                const SizedBox(height: 12),

                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ...unlockedAchievements.map((achievement) =>
                      _buildAchievementBadge(achievement, isUnlocked: true)),
                    ...lockedAchievements.map((achievement) =>
                      _buildAchievementBadge(achievement, isUnlocked: false)),
                  ],
                ),

                const SizedBox(height: 24),

                // Life Wheel
                Text(
                  'Колесо баланса',
                  style: AppTextStyles.h3,
                ).animate(delay: 600.ms).fadeIn(),

                const SizedBox(height: 12),

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
                          _buildStatItem('Средний балл', '${lifeWheel.averageBalance.toInt()}'),
                          _buildStatItem('Гармония', '${(lifeWheel.harmony * 100).toInt()}%'),
                        ],
                      ),
                    ],
                  ),
                ).animate(delay: 700.ms).fadeIn().scale(begin: const Offset(0.9, 0.9)),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementBadge(Achievement achievement, {required bool isUnlocked}) {
    return Container(
      width: 80,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUnlocked
          ? AppColors.primary.withOpacity(0.2)
          : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUnlocked ? AppColors.primary : Colors.white.withOpacity(0.1),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            achievement.emoji,
            style: TextStyle(
              fontSize: 32,
              color: isUnlocked ? null : Colors.white.withOpacity(0.3),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            achievement.title,
            style: AppTextStyles.caption.copyWith(
              fontSize: 10,
              color: isUnlocked ? null : Colors.white.withOpacity(0.3),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.h2.copyWith(fontSize: 24)),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}
