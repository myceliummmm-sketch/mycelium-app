import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../models/activity_model.dart';

class AIScreen extends StatelessWidget {
  const AIScreen({super.key});

  final List<ActivityModel> _activities = const [
    ActivityModel(
      id: '1',
      type: ActivityType.testCompleted,
      title: 'Завершен тест Big Five',
      description: 'Вы прошли тест на большую пятерку личностных черт',
      aiComment:
          'Отлично! Ваша высокая открытость новому опыту (87%) отлично сочетается с развитым критическим мышлением. Рекомендую попробовать креативные тесты для максимального раскрытия потенциала.',
      timestamp: '2 часа назад',
      emoji: '⭐',
      metadata: {
        'tokens': 75,
        'metaskills': ['Самосознание', 'Адаптивность']
      },
    ),
    ActivityModel(
      id: '2',
      type: ActivityType.p2pCall,
      title: 'Рулетка с Анной К.',
      description: 'Обсуждение стартапов и инноваций',
      aiComment:
          'Заметил яркую синергию! У вас совпадение по метаскилам "Креативность" и "Системное мышление". Анна тоже интересуется предпринимательством. Вы обменялись контактами - отличный нетворкинг!',
      timestamp: '5 часов назад',
      emoji: '🎲',
      metadata: {'duration': '23 мин', 'rating': 5},
    ),
    ActivityModel(
      id: '3',
      type: ActivityType.levelUp,
      title: 'Новый уровень!',
      description: 'Вы достигли 8 уровня',
      aiComment:
          'Поздравляю с 8 уровнем! За последнюю неделю заметен прогресс в эмоциональных метаскилах (+15%). Продолжайте в том же духе, и к концу месяца откроется доступ к эксклюзивным тестам.',
      timestamp: 'вчера',
      emoji: '🎉',
      metadata: {'level': 8, 'nextLevelProgress': 0.45},
    ),
    ActivityModel(
      id: '4',
      type: ActivityType.testCompleted,
      title: 'Завершен тест на эмпатию',
      description: 'Оценка уровня сопереживания',
      aiComment:
          'Ваш уровень эмпатии 78% - это выше среднего! Это коррелирует с высокими показателями в коммуникации. Люди с похожим профилем часто успешны в HR и психологии.',
      timestamp: 'вчера',
      emoji: '❤️',
      metadata: {'tokens': 40, 'score': 78},
    ),
    ActivityModel(
      id: '5',
      type: ActivityType.p2pCall,
      title: 'Рулетка с Дмитрием С.',
      description: 'Разговор о карьерном росте',
      aiComment:
          'Интересная беседа! Дмитрий показал высокую экспертизу в области финансов. Вы оба набрали высокие баллы по "Планированию" - возможно, стоит продолжить общение для обмена опытом.',
      timestamp: '2 дня назад',
      emoji: '🎲',
      metadata: {'duration': '18 мин', 'rating': 4},
    ),
    ActivityModel(
      id: '6',
      type: ActivityType.achievement,
      title: 'Достижение разблокировано',
      description: 'Первая неделя с активностью каждый день',
      aiComment:
          'Отличная последовательность! 7 дней подряд активности повышают ваш метаскил "Мотивация". Такая регулярность - ключ к устойчивому росту.',
      timestamp: '2 дня назад',
      emoji: '🏆',
      metadata: {'streak': 7},
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'AI Фидбэк',
                      style: AppTextStyles.h1,
                    ).animate().fadeIn().slideX(begin: -0.2, end: 0),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            gradient: AppGradients.primaryGradient,
                            shape: BoxShape.circle,
                          ),
                        )
                            .animate(onPlay: (controller) => controller.repeat())
                            .fadeIn(duration: 1000.ms)
                            .fadeOut(duration: 1000.ms),
                        const SizedBox(width: 8),
                        const Text(
                          'Команда AI Mycelium следит за вашим ростом',
                          style: AppTextStyles.bodySecondary,
                        ),
                      ],
                    ).animate().fadeIn(delay: 100.ms),
                  ],
                ),
              ),

              // Activity feed
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _activities.length,
                  itemBuilder: (context, index) {
                    return _buildActivityCard(
                      context,
                      activity: _activities[index],
                      delay: index * 100,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard(
    BuildContext context, {
    required ActivityModel activity,
    required int delay,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: AppDecorations.cardBackground,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                if (activity.emoji != null)
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: _getGradientForType(activity.type),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        activity.emoji!,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.title,
                        style: AppTextStyles.h3,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        activity.timestamp,
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Activity description
            Text(
              activity.description,
              style: AppTextStyles.body,
            ),

            // Metadata badges
            if (activity.metadata != null) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _buildMetadataBadges(activity.metadata!),
              ),
            ],

            const SizedBox(height: 16),

            // AI Comment section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryPurple.withOpacity(0.1),
                    AppColors.primaryBlue.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primaryPurple.withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          gradient: AppGradients.primaryGradient,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.psychology,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'AI комментарий',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryPurple,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    activity.aiComment,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                  ),

                  // Show metaskill/balance changes
                  if (_hasSkillChanges(activity)) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Изменения навыков',
                            style: AppTextStyles.caption.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.success,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ..._buildSkillChanges(activity),
                        ],
                      ),
                    ),
                  ],

                  // Details button
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        _showDetailedAnalysis(context, activity);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: AppColors.primaryPurple.withOpacity(0.5),
                          width: 1.5,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Подробнее',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryPurple,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: AppColors.primaryPurple,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: delay))
        .slideY(begin: 0.1, end: 0);
  }

  List<Widget> _buildMetadataBadges(Map<String, dynamic> metadata) {
    List<Widget> badges = [];

    if (metadata.containsKey('tokens')) {
      badges.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.warning.withOpacity(0.2),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: AppColors.warning.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.token, size: 12, color: AppColors.warning),
              const SizedBox(width: 4),
              Text(
                '+${metadata['tokens']} MYC',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.warning,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (metadata.containsKey('duration')) {
      badges.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: AppColors.primaryBlue.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.timer, size: 12, color: AppColors.primaryBlue),
              const SizedBox(width: 4),
              Text(
                metadata['duration'],
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (metadata.containsKey('rating')) {
      badges.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.2),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: AppColors.success.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, size: 12, color: AppColors.success),
              const SizedBox(width: 4),
              Text(
                '${metadata['rating']}/5',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (metadata.containsKey('level')) {
      badges.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            gradient: AppGradients.primaryGradient,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.arrow_upward, size: 12, color: Colors.white),
              const SizedBox(width: 4),
              Text(
                'Уровень ${metadata['level']}',
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (metadata.containsKey('streak')) {
      badges.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            gradient: AppGradients.warningGradient,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🔥', style: TextStyle(fontSize: 12)),
              const SizedBox(width: 4),
              Text(
                '${metadata['streak']} дней',
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (metadata.containsKey('metaskills')) {
      final metaskills = metadata['metaskills'] as List;
      for (var skill in metaskills) {
        badges.add(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: AppColors.primaryPurple.withOpacity(0.3),
              ),
            ),
            child: Text(
              skill,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primaryPurple,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }
    }

    if (metadata.containsKey('score')) {
      badges.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.2),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: AppColors.success.withOpacity(0.3),
            ),
          ),
          child: Text(
            '${metadata['score']}%',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.success,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }

    return badges;
  }

  bool _hasSkillChanges(ActivityModel activity) {
    return activity.type == ActivityType.testCompleted ||
        activity.type == ActivityType.p2pCall;
  }

  List<Widget> _buildSkillChanges(ActivityModel activity) {
    // Mock skill changes based on activity type
    final List<Map<String, dynamic>> changes = [];

    if (activity.type == ActivityType.testCompleted) {
      changes.addAll([
        {'name': 'Самосознание', 'change': 5, 'emoji': '🧠'},
        {'name': 'Здоровье', 'change': 3, 'emoji': '💪', 'isBalance': true},
      ]);
    } else if (activity.type == ActivityType.p2pCall) {
      changes.addAll([
        {'name': 'Коммуникация', 'change': 4, 'emoji': '💬'},
        {'name': 'Отношения', 'change': 2, 'emoji': '❤️', 'isBalance': true},
      ]);
    }

    return changes.map((change) {
      final isBalance = change['isBalance'] == true;
      return Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          children: [
            Text(
              change['emoji'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                change['name'],
                style: AppTextStyles.body.copyWith(fontSize: 13),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '+${change['change']}',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              isBalance ? Icons.pie_chart : Icons.trending_up,
              size: 14,
              color: AppColors.success,
            ),
          ],
        ),
      );
    }).toList();
  }

  Gradient _getGradientForType(ActivityType type) {
    switch (type) {
      case ActivityType.testCompleted:
        return AppGradients.purpleGradient;
      case ActivityType.p2pCall:
        return AppGradients.primaryGradient;
      case ActivityType.levelUp:
        return AppGradients.successGradient;
      case ActivityType.achievement:
        return AppGradients.yellowGradient;
    }
  }

  void _showDetailedAnalysis(BuildContext context, ActivityModel activity) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
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
                    // Header
                    Row(
                      children: [
                        Text(
                          activity.emoji ?? '⭐',
                          style: const TextStyle(fontSize: 48),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                activity.title,
                                style: AppTextStyles.h2,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                activity.timestamp,
                                style: AppTextStyles.caption,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // AI Deep Analysis
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryPurple.withOpacity(0.2),
                            AppColors.primaryBlue.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.primaryPurple.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text('🤖', style: TextStyle(fontSize: 24)),
                              const SizedBox(width: 12),
                              Text(
                                'Детальный анализ AI',
                                style: AppTextStyles.h3,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            activity.aiComment,
                            style: AppTextStyles.body.copyWith(height: 1.6),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Activity Details
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: AppDecorations.cardBackground,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Подробности',
                            style: AppTextStyles.h3,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            activity.description,
                            style: AppTextStyles.body.copyWith(height: 1.5),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Impact on Skills
                    if (activity.metadata?.containsKey('metaskills') ?? false)
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: AppDecorations.cardBackground,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('📈', style: TextStyle(fontSize: 20)),
                                const SizedBox(width: 12),
                                Text(
                                  'Влияние на метанавыки',
                                  style: AppTextStyles.h3,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ...((activity.metadata?['metaskills'] as List? ?? []).map(
                              (skill) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        gradient: AppGradients.primaryGradient,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(
                                        Icons.trending_up,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        skill.toString(),
                                        style: AppTextStyles.body,
                                      ),
                                    ),
                                    Text(
                                      '+${(5 + (skill.toString().hashCode % 10))}%',
                                      style: AppTextStyles.body.copyWith(
                                        color: AppColors.success,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),

                    const SizedBox(height: 20),

                    // Recommendations
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.success.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text('💡', style: TextStyle(fontSize: 20)),
                              const SizedBox(width: 12),
                              Text(
                                'Рекомендации',
                                style: AppTextStyles.h3,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _getRecommendationForType(activity.type),
                            style: AppTextStyles.body.copyWith(height: 1.5),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ).animate().fadeIn().slideY(begin: 0.1, end: 0),
    );
  }

  String _getRecommendationForType(ActivityType type) {
    switch (type) {
      case ActivityType.testCompleted:
        return 'Продолжайте проходить тесты для более глубокого самопознания. Рекомендуем попробовать тесты из других категорий для комплексного развития.';
      case ActivityType.p2pCall:
        return 'Отличная практика! Продолжайте общаться с разными людьми для развития коммуникативных навыков. Попробуйте новые сценарии для расширения опыта.';
      case ActivityType.levelUp:
        return 'Поздравляем с новым уровнем! Продолжайте регулярные занятия для поддержания прогресса. Следующий уровень откроет новые возможности.';
      case ActivityType.achievement:
        return 'Вы получили достижение! Это показывает ваш стабильный прогресс. Продолжайте в том же духе для получения новых наград.';
    }
  }
}
