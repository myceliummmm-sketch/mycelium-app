// Результаты всех тестов онбординга

class TestResult {
  // DISC scores (Dominance, Influence, Steadiness, Compliance)
  final Map<String, int> discScores;

  // Big Five scores (Openness, Conscientiousness, Extraversion, Agreeableness, Neuroticism)
  final Map<String, int> bigFiveScores;

  // Выбранные ценности (5 штук)
  final List<String> selectedValues;

  // Болевые точки (1-3 штуки)
  final List<String> painPoints;

  // Рассчитанный психотип
  final String psychotype;

  // Описание психотипа
  final String description;

  // Суперсилы
  final List<String> superpowers;

  // Вызовы
  final List<String> challenges;

  TestResult({
    required this.discScores,
    required this.bigFiveScores,
    required this.selectedValues,
    required this.painPoints,
    required this.psychotype,
    required this.description,
    required this.superpowers,
    required this.challenges,
  });

  // Получить доминирующий DISC тип
  String get dominantDiscType {
    final sorted = discScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.first.key;
  }

  // Получить средний балл Big Five
  double get averageBigFiveScore {
    final values = bigFiveScores.values.toList();
    return values.reduce((a, b) => a + b) / values.length;
  }

  // Factory для создания из тестовых данных
  factory TestResult.fromAnswers({
    required Map<String, int> discScores,
    required Map<String, int> bigFiveScores,
    required List<String> values,
    required List<String> pains,
  }) {
    // Определяем психотип на основе DISC
    final dominantType = discScores.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;

    String psychotype;
    String description;
    List<String> superpowers;
    List<String> challenges;

    switch (dominantType) {
      case 'D': // Dominance
        psychotype = 'СТРАТЕГ-ВИЗИОНЕР';
        description =
            'Ты прирожденный лидер с нестандартным мышлением. Любишь вызовы и быстрые решения.';
        superpowers = [
          'Решительность в критических ситуациях',
          'Видишь возможности, где другие видят проблемы',
          'Не боишься рисковать'
        ];
        challenges = [
          'Нетерпелив к медленным людям',
          'Можешь задавить энергией',
          'Детали вызывают скуку'
        ];
        break;

      case 'I': // Influence
        psychotype = 'ВДОХНОВИТЕЛЬ';
        description =
            'Ты заряжаешь людей энергией и оптимизмом. Умеешь объединять команды.';
        superpowers = [
          'Легко находишь общий язык',
          'Креативный подход к решениям',
          'Мотивируешь других'
        ];
        challenges = [
          'Сложно с рутиной и деталями',
          'Иногда обещаешь больше чем можешь',
          'Нужно одобрение окружающих'
        ];
        break;

      case 'S': // Steadiness
        psychotype = 'ГАРМОНИЗАТОР';
        description =
            'Ты надежный и стабильный. Создаешь атмосферу доверия и поддержки.';
        superpowers = [
          'Терпелив и последователен',
          'Отличный слушатель',
          'Сглаживаешь конфликты'
        ];
        challenges = [
          'Сложно говорить "нет"',
          'Избегаешь конфликтов даже нужных',
          'Медленно адаптируешься к переменам'
        ];
        break;

      case 'C': // Compliance
        psychotype = 'АНАЛИТИК-ЭКСПЕРТ';
        description =
            'Ты ценишь точность и качество. Глубоко погружаешься в детали.';
        superpowers = [
          'Внимателен к деталям',
          'Логичный и системный',
          'Высокие стандарты качества'
        ];
        challenges = [
          'Перфекционизм замедляет',
          'Критичен к себе и другим',
          'Сложно принимать быстрые решения'
        ];
        break;

      default:
        psychotype = 'УНИВЕРСАЛ';
        description = 'У тебя сбалансированный профиль всех качеств.';
        superpowers = ['Гибкость', 'Адаптивность', 'Разносторонность'];
        challenges = [
          'Сложно определить приоритеты',
          'Иногда размыт фокус'
        ];
    }

    return TestResult(
      discScores: discScores,
      bigFiveScores: bigFiveScores,
      selectedValues: values,
      painPoints: pains,
      psychotype: psychotype,
      description: description,
      superpowers: superpowers,
      challenges: challenges,
    );
  }
}
