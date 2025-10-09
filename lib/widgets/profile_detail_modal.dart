import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../models/user_model.dart';
import '../models/level_system.dart';
import '../models/achievement.dart';

class ProfileDetailModal extends StatelessWidget {
  const ProfileDetailModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ProfileDetailModal(),
    );
  }

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
    final achievements = Achievement.getInitialAchievements();
    final unlockedAchievements = achievements.take(4).map((a) =>
      a.copyWith(isUnlocked: true)).toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.background, Color(0xFF1A1F3A)],
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: AppColors.primaryPurple,
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
                        // Myc tokens
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.warning.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.warning,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('💰', style: TextStyle(fontSize: 20)),
                              const SizedBox(width: 4),
                              Text(
                                '${user.mycTokens}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.warning,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).animate().fadeIn().slideX(begin: -0.2, end: 0),

                    const SizedBox(height: 24),

                    // Level & Trust Score Card
                    GestureDetector(
                      onTap: () {
                        // TODO: Open level details
                      },
                      child: Container(
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
                                        const Text(
                                          '🔮',
                                          style: TextStyle(fontSize: 28),
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'СТРАТЕГ-ВИЗИОНЕР',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
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
                      ),
                    ).animate(delay: 100.ms).fadeIn().slideY(begin: 0.2, end: 0),

                    const SizedBox(height: 24),

                    // Stats
                    Text(
                      'Статистика',
                      style: AppTextStyles.h3,
                    ).animate(delay: 200.ms).fadeIn(),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            '📝',
                            'Тестов',
                            '${user.stats?.testsCompleted ?? 0}',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            '🎮',
                            'P2P',
                            '${user.stats?.p2pCalls ?? 0}',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            '🔥',
                            'Стрик',
                            '${user.streakDays}',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Who Am I - All test results
                    Text(
                      'Кто я?',
                      style: AppTextStyles.h3,
                    ).animate(delay: 300.ms).fadeIn(),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: AppDecorations.cardBackground,
                      child: Column(
                        children: [
                          _buildTestResultCard('DISC', 'D/I', 'Доминирование + Влияние'),
                          const SizedBox(height: 12),
                          _buildTestResultCard('MBTI', 'ENTJ', 'Командир-Стратег'),
                          const SizedBox(height: 12),
                          _buildTestResultCard('Enneagram', '8w7', 'Challenger'),
                          const SizedBox(height: 12),
                          _buildTestResultCard('Big Five', 'SCOEI', 'Высокая Экстраверсия'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Achievements
                    Text(
                      'Последние достижения',
                      style: AppTextStyles.h3,
                    ).animate(delay: 400.ms).fadeIn(),

                    const SizedBox(height: 12),

                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: unlockedAchievements.map((achievement) =>
                        _buildAchievementBadge(achievement)).toList(),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String emoji, String label, String value) {
    return GestureDetector(
      onTap: () {
        // TODO: Open detailed stats
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: AppDecorations.cardBackground,
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text(
              value,
              style: AppTextStyles.h2.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestResultCard(String testName, String result, String description) {
    return GestureDetector(
      onTap: () {
        // TODO: Open detailed test results
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: AppGradients.primaryGradient,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    testName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    result,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white60,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementBadge(Achievement achievement) {
    return GestureDetector(
      onTap: () {
        // TODO: Show achievement details
      },
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.primaryPurple.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primaryPurple,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(
              achievement.emoji,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 4),
            Text(
              achievement.title,
              style: AppTextStyles.caption.copyWith(fontSize: 10),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
