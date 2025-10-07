class Achievement {
  final String id;
  final String title;
  final String description;
  final String emoji;
  final int mycReward;
  final bool isUnlocked;
  final double progress;
  final String? unlockedAt;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    required this.mycReward,
    this.isUnlocked = false,
    this.progress = 0.0,
    this.unlockedAt,
  });

  Achievement copyWith({
    bool? isUnlocked,
    double? progress,
    String? unlockedAt,
  }) {
    return Achievement(
      id: id,
      title: title,
      description: description,
      emoji: emoji,
      mycReward: mycReward,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      progress: progress ?? this.progress,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }

  static List<Achievement> getInitialAchievements() {
    return [
      Achievement(
        id: 'first_contact',
        title: 'Первый контакт',
        description: 'Завершена первая сессия - ты начал свой путь роста',
        emoji: '🤝',
        mycReward: 50,
      ),
      Achievement(
        id: 'good_partner',
        title: 'Хороший партнер',
        description: 'Получена первая оценка 5 звезд - тебя высоко оценили',
        emoji: '⭐',
        mycReward: 100,
      ),
      Achievement(
        id: 'consistency',
        title: 'Постоянство',
        description:
            '3 сессии за 7 дней - регулярная практика дает результат',
        emoji: '📅',
        mycReward: 150,
      ),
      Achievement(
        id: 'explorer',
        title: 'Исследователь',
        description: 'Опробовано 3 разных сценария - ты пробуешь разные подходы',
        emoji: '🗺️',
        mycReward: 100,
      ),
      Achievement(
        id: 'first_growth',
        title: 'Первый рост',
        description: 'Любой навык вырос на 5 пунктов - измеримый прогресс',
        emoji: '📈',
        mycReward: 200,
      ),
      Achievement(
        id: 'trusted',
        title: 'Надежный',
        description: 'Trust Score >= 70 - сообщество тебе доверяет',
        emoji: '🛡️',
        mycReward: 150,
      ),
      Achievement(
        id: 'multitalent',
        title: 'Мультиталант',
        description:
            'Практика навыков из 2 разных кластеров - развиваешься разносторонне',
        emoji: '🎭',
        mycReward: 100,
      ),
    ];
  }
}
