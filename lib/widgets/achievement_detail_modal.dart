import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/achievement.dart';
import '../theme/app_theme.dart';

class AchievementDetailModal extends StatelessWidget {
  final Achievement achievement;

  const AchievementDetailModal({
    super.key,
    required this.achievement,
  });

  static void show(BuildContext context, Achievement achievement) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AchievementDetailModal(achievement: achievement),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
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
                children: [
                  // Large emoji
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: achievement.isUnlocked
                          ? AppGradients.primaryGradient
                          : LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.1),
                                Colors.white.withOpacity(0.05),
                              ],
                            ),
                      boxShadow: achievement.isUnlocked
                          ? [
                              BoxShadow(
                                color: AppColors.primaryPurple.withOpacity(0.5),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        achievement.emoji,
                        style: TextStyle(
                          fontSize: 64,
                          color: achievement.isUnlocked
                              ? null
                              : Colors.white.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ).animate().scale(
                        duration: 500.ms,
                        curve: Curves.elasticOut,
                      ),

                  const SizedBox(height: 24),

                  // Title
                  Text(
                    achievement.title,
                    style: AppTextStyles.h1.copyWith(
                      color: achievement.isUnlocked
                          ? Colors.white
                          : AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ).animate(delay: 100.ms).fadeIn(),

                  const SizedBox(height: 8),

                  // Status badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: achievement.isUnlocked
                          ? AppColors.success.withOpacity(0.2)
                          : Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: achievement.isUnlocked
                            ? AppColors.success
                            : Colors.white.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: Text(
                      achievement.isUnlocked ? 'Получено' : 'Заблокировано',
                      style: AppTextStyles.caption.copyWith(
                        color: achievement.isUnlocked
                            ? AppColors.success
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ).animate(delay: 150.ms).fadeIn().scale(),

                  const SizedBox(height: 24),

                  // Description
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: AppDecorations.cardBackground,
                    child: Text(
                      achievement.description,
                      style: AppTextStyles.body.copyWith(height: 1.6),
                      textAlign: TextAlign.center,
                    ),
                  ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 20),

                  // Reward
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: AppGradients.warningGradient,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '🪙',
                          style: TextStyle(fontSize: 32),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Награда',
                              style: AppTextStyles.caption,
                            ),
                            Text(
                              '+${achievement.mycReward} MYC',
                              style: AppTextStyles.h2.copyWith(fontSize: 28),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).animate(delay: 250.ms).fadeIn().scale(begin: const Offset(0.9, 0.9)),

                  if (achievement.isUnlocked) ...[
                    const SizedBox(height: 20),

                    // Unlocked date (mock)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: AppColors.success,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Получено 15 января 2025',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.success,
                            ),
                          ),
                        ],
                      ),
                    ).animate(delay: 300.ms).fadeIn(),
                  ] else ...[
                    const SizedBox(height: 20),

                    // How to unlock
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primaryPurple.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primaryPurple.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                '💡',
                                style: TextStyle(fontSize: 24),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _getHowToUnlock(achievement.id),
                                  style: AppTextStyles.body,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ).animate(delay: 300.ms).fadeIn(),
                  ],

                  const SizedBox(height: 24),

                  // Close button
                  if (!achievement.isUnlocked)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryPurple,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Понятно',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ).animate(delay: 350.ms).fadeIn().slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getHowToUnlock(String achievementId) {
    switch (achievementId) {
      case 'first_contact':
        return 'Пройдите первый P2P звонок чтобы разблокировать';
      case 'good_partner':
        return 'Получите 5 высоких оценок от партнеров';
      case 'test_master':
        return 'Пройдите 5 тестов личности';
      case 'streak_warrior':
        return 'Поддерживайте активность 7 дней подряд';
      case 'ai_explorer':
        return 'Получите 3 развернутых отчета от AI';
      case 'community_builder':
        return 'Пригласите 5 друзей в приложение';
      case 'level_achiever':
        return 'Достигните 10 уровня';
      default:
        return 'Продолжайте использовать приложение';
    }
  }
}
