import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/user_profile_provider.dart';
import '../../models/sphere_progress.dart';

class MCodeDashboardScreen extends StatelessWidget {
  const MCodeDashboardScreen({super.key});

  void _showInfoModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.primaryPurple,
                ),
                const SizedBox(width: 12),
                Text(
                  'Как работает mCode?',
                  style: AppTextStyles.h2,
                ),
              ],
            ),
            const SizedBox(height: 20),
            _InfoItem(
              icon: Icons.star_outline,
              text: 'Выполняй задания и получай XP',
            ),
            const SizedBox(height: 12),
            _InfoItem(
              icon: Icons.trending_up,
              text: 'Повышай уровень и открывай новые сферы',
            ),
            const SizedBox(height: 12),
            _InfoItem(
              icon: Icons.people_outline,
              text: 'На 5 уровне откроется P2P сообщество',
            ),
            const SizedBox(height: 12),
            _InfoItem(
              icon: Icons.hub_outlined,
              text: 'Развивай все 8 сфер жизни',
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Понятно',
                  style: AppTextStyles.body.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Consumer<UserProfileProvider>(
          builder: (context, provider, _) {
            final profile = provider.profile;

            return CustomScrollView(
              slivers: [
                // App Bar
                SliverAppBar(
                  floating: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    'mCode',
                    style: AppTextStyles.h2,
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.info_outline),
                      onPressed: () => _showInfoModal(context),
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        // Для тестирования - сброс профиля
                        provider.reset();
                      },
                    ),
                  ],
                ),

                // Контент
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Приветствие и уровень
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Привет, ${profile.name}!',
                              style: AppTextStyles.h1.copyWith(fontSize: 28),
                            ).animate()
                              .fadeIn(duration: 400.ms)
                              .slideX(begin: -0.2, end: 0, duration: 400.ms),

                            const SizedBox(height: 8),

                            Text(
                              profile.testResult?.psychotype ?? 'Новичок',
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.primaryPurple,
                              ),
                            ).animate()
                              .fadeIn(delay: 200.ms, duration: 400.ms),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Карточка уровня
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: _LevelCard(
                          level: profile.currentLevel,
                          totalXP: profile.totalXP,
                          progress: profile.levelProgress,
                          xpForNext: profile.xpForNextLevel,
                        ).animate()
                          .fadeIn(delay: 400.ms, duration: 400.ms)
                          .slideY(begin: 0.2, end: 0, delay: 400.ms, duration: 400.ms),
                      ),

                      const SizedBox(height: 32),

                      // P2P статус
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: _P2PCard(
                          isUnlocked: profile.isP2PUnlocked,
                          currentLevel: profile.currentLevel,
                        ).animate()
                          .fadeIn(delay: 600.ms, duration: 400.ms)
                          .slideY(begin: 0.2, end: 0, delay: 600.ms, duration: 400.ms),
                      ),

                      const SizedBox(height: 32),

                      // Заголовок сфер
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Твои сферы',
                              style: AppTextStyles.h2,
                            ),
                            Text(
                              '${profile.unlockedSpheresCount} / ${profile.spheres.length}',
                              style: AppTextStyles.body.copyWith(
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ).animate()
                          .fadeIn(delay: 800.ms, duration: 400.ms),
                      ),

                      const SizedBox(height: 16),

                      // Горизонтальный скролл сфер
                      SizedBox(
                        height: 280,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          itemCount: profile.spheres.length,
                          itemBuilder: (context, index) {
                            final sphere = profile.spheres[index];

                            return Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: _SphereCard(
                                sphere: sphere,
                                onTap: () {
                                  // Для демо - добавляем XP при тапе
                                  if (sphere.isUnlocked) {
                                    provider.addXP(10, sphereId: sphere.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('+10 XP в сфере ${sphere.name}'),
                                        backgroundColor: sphere.color,
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                  }
                                },
                              ).animate()
                                .fadeIn(delay: (1000 + index * 100).ms, duration: 400.ms)
                                .slideX(
                                  begin: 0.2,
                                  end: 0,
                                  delay: (1000 + index * 100).ms,
                                  duration: 400.ms,
                                ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Подсказка для демо
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.info.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.info.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.touch_app,
                                color: AppColors.info,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Тапай на разблокированные сферы чтобы получить +10 XP (демо)',
                                  style: AppTextStyles.caption.copyWith(
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ).animate()
                          .fadeIn(delay: 1600.ms, duration: 400.ms),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  final int level;
  final int totalXP;
  final double progress;
  final int xpForNext;

  const _LevelCard({
    required this.level,
    required this.totalXP,
    required this.progress,
    required this.xpForNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppGradients.primaryGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Уровень $level',
                    style: AppTextStyles.h1.copyWith(fontSize: 32),
                  ),
                  Text(
                    'Всего XP: $totalXP',
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    level.toString(),
                    style: AppTextStyles.h1.copyWith(fontSize: 28),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Прогресс бар
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'До уровня ${level + 1}',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    '$xpForNext XP',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 12,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _P2PCard extends StatelessWidget {
  final bool isUnlocked;
  final int currentLevel;

  const _P2PCard({
    required this.isUnlocked,
    required this.currentLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isUnlocked
            ? AppColors.success.withOpacity(0.1)
            : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUnlocked
              ? AppColors.success.withOpacity(0.5)
              : Colors.white.withOpacity(0.1),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isUnlocked
                  ? AppColors.success.withOpacity(0.2)
                  : Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isUnlocked ? Icons.lock_open : Icons.lock_outline,
              color: isUnlocked ? AppColors.success : Colors.white60,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'P2P Сообщество',
                  style: AppTextStyles.h3.copyWith(fontSize: 18),
                ),
                Text(
                  isUnlocked
                      ? 'Разблокировано! Общайся с единомышленниками'
                      : 'Откроется на уровне 5 (сейчас $currentLevel)',
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),
          if (isUnlocked)
            Icon(
              Icons.check_circle,
              color: AppColors.success,
              size: 32,
            ),
        ],
      ),
    );
  }
}

class _SphereCard extends StatelessWidget {
  final SphereProgress sphere;
  final VoidCallback onTap;

  const _SphereCard({
    required this.sphere,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: sphere.isUnlocked ? onTap : null,
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: sphere.isUnlocked
              ? sphere.color.withOpacity(0.1)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: sphere.isUnlocked
                ? sphere.color.withOpacity(0.5)
                : Colors.white.withOpacity(0.1),
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Эмодзи и статус
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sphere.emoji,
                  style: TextStyle(
                    fontSize: 48,
                    color: sphere.isUnlocked ? null : Colors.white.withOpacity(0.3),
                  ),
                ),
                if (!sphere.isUnlocked)
                  Icon(
                    Icons.lock_outline,
                    color: Colors.white60,
                  ),
              ],
            ),

            const SizedBox(height: 16),

            // Название
            Text(
              sphere.name,
              style: AppTextStyles.h3.copyWith(
                fontSize: 20,
                color: sphere.isUnlocked ? Colors.white : Colors.white60,
              ),
            ),

            const SizedBox(height: 8),

            // Описание или уровень разблокировки
            Text(
              sphere.isUnlocked
                  ? sphere.description
                  : 'Уровень ${sphere.level}',
              style: AppTextStyles.caption.copyWith(
                color: Colors.white60,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 16),

            // Рейтинг или прогресс
            if (sphere.isUnlocked)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Рейтинг',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white60,
                        ),
                      ),
                      Text(
                        '${sphere.userRating}/10',
                        style: AppTextStyles.body.copyWith(
                          color: sphere.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: sphere.userRating / 10,
                      minHeight: 6,
                      backgroundColor: Colors.white.withOpacity(0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(sphere.color),
                    ),
                  ),
                ],
              )
            else
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 16,
                      color: Colors.white60,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Заблокирована',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white60,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primaryPurple,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.body.copyWith(
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }
}
