import 'package:flutter/material.dart';

enum MetaskillDomain {
  cognitive('Когнитивные', '🧠', Color(0xFF6366F1)),
  social('Социальные', '🤝', Color(0xFFEC4899)),
  emotional('Эмоциональные', '❤️', Color(0xFF10B981)),
  practical('Практические', '⚡', Color(0xFFF59E0B));

  final String title;
  final String emoji;
  final Color color;

  const MetaskillDomain(this.title, this.emoji, this.color);
}

class MetaskillDetailed {
  final String id;
  final String title;
  final String emoji;
  final MetaskillDomain domain;
  final String description;
  final double currentLevel; // 0-100
  final List<String> howToImprove;
  final String shortTip;

  const MetaskillDetailed({
    required this.id,
    required this.title,
    required this.emoji,
    required this.domain,
    required this.description,
    required this.currentLevel,
    required this.howToImprove,
    required this.shortTip,
  });

  static List<MetaskillDetailed> getAll16Skills() {
    return [
      // Когнитивные (4)
      MetaskillDetailed(
        id: 'critical_thinking',
        title: 'Критическое мышление',
        emoji: '🧠',
        domain: MetaskillDomain.cognitive,
        description: 'Способность анализировать информацию объективно и формировать взвешенные суждения',
        currentLevel: 75,
        howToImprove: [
          'Проходите тесты на логику',
          'Практикуйте анализ кейсов в P2P',
          'Читайте материалы по критическому мышлению',
        ],
        shortTip: 'Задавайте "почему?" минимум 3 раза',
      ),
      MetaskillDetailed(
        id: 'creativity',
        title: 'Креативность',
        emoji: '💡',
        domain: MetaskillDomain.cognitive,
        description: 'Умение генерировать оригинальные идеи и нестандартные решения',
        currentLevel: 82,
        howToImprove: [
          'Участвуйте в креативных P2P сессиях',
          'Решайте творческие задачи',
          'Пробуйте новые хобби',
        ],
        shortTip: 'Комбинируйте несвязанные концепции',
      ),
      MetaskillDetailed(
        id: 'analytics',
        title: 'Аналитика',
        emoji: '📊',
        domain: MetaskillDomain.cognitive,
        description: 'Способность работать с данными, находить паттерны и делать выводы',
        currentLevel: 68,
        howToImprove: [
          'Анализируйте свою статистику в приложении',
          'Проходите тесты на аналитику',
          'Практикуйте работу с данными',
        ],
        shortTip: 'Ищите тренды и аномалии',
      ),
      MetaskillDetailed(
        id: 'decision_making',
        title: 'Принятие решений',
        emoji: '🎯',
        domain: MetaskillDomain.cognitive,
        description: 'Умение быстро и эффективно принимать решения в условиях неопределенности',
        currentLevel: 72,
        howToImprove: [
          'Тренируйтесь на сценариях принятия решений',
          'Используйте фреймворки (SWOT, матрица Эйзенхауэра)',
          'Анализируйте последствия своих решений',
        ],
        shortTip: 'Определите критерии до выбора',
      ),

      // Социальные (4)
      MetaskillDetailed(
        id: 'communication',
        title: 'Коммуникация',
        emoji: '🤝',
        domain: MetaskillDomain.social,
        description: 'Способность ясно выражать мысли и эффективно взаимодействовать с людьми',
        currentLevel: 78,
        howToImprove: [
          'Практикуйтесь в P2P рулетке',
          'Записывайте себя на видео',
          'Просите фидбэк после общения',
        ],
        shortTip: 'Слушайте больше, чем говорите',
      ),
      MetaskillDetailed(
        id: 'collaboration',
        title: 'Сотрудничество',
        emoji: '👥',
        domain: MetaskillDomain.social,
        description: 'Умение работать в команде и достигать общих целей',
        currentLevel: 85,
        howToImprove: [
          'Участвуйте в групповых P2P сессиях',
          'Практикуйте активное слушание',
          'Изучайте ролевые модели в команде',
        ],
        shortTip: 'Фокус на общей цели, не на эго',
      ),
      MetaskillDetailed(
        id: 'persuasion',
        title: 'Убеждение',
        emoji: '🎭',
        domain: MetaskillDomain.social,
        description: 'Способность влиять на мнение и решения других людей',
        currentLevel: 65,
        howToImprove: [
          'Тренируйтесь на сценариях переговоров',
          'Изучайте техники аргументации',
          'Практикуйте сторителлинг',
        ],
        shortTip: 'Найдите интересы собеседника',
      ),
      MetaskillDetailed(
        id: 'networking',
        title: 'Нетворкинг',
        emoji: '🌐',
        domain: MetaskillDomain.social,
        description: 'Умение создавать и поддерживать полезные связи',
        currentLevel: 58,
        howToImprove: [
          'Используйте P2P рулетку для знакомств',
          'Помогайте другим без ожиданий',
          'Регулярно поддерживайте контакты',
        ],
        shortTip: 'Дайте ценность до просьбы',
      ),

      // Эмоциональные (4)
      MetaskillDetailed(
        id: 'empathy',
        title: 'Эмпатия',
        emoji: '❤️',
        domain: MetaskillDomain.emotional,
        description: 'Способность понимать и разделять чувства других людей',
        currentLevel: 88,
        howToImprove: [
          'Практикуйте активное слушание в P2P',
          'Задавайте открытые вопросы',
          'Отражайте чувства собеседника',
        ],
        shortTip: 'Поставьте себя на место другого',
      ),
      MetaskillDetailed(
        id: 'emotional_intelligence',
        title: 'Эмоциональный интеллект',
        emoji: '😌',
        domain: MetaskillDomain.emotional,
        description: 'Осознание и управление своими эмоциями и эмоциями других',
        currentLevel: 76,
        howToImprove: [
          'Ведите дневник эмоций',
          'Проходите тесты EQ',
          'Практикуйте майндфулнесс',
        ],
        shortTip: 'Назовите эмоцию, чтобы её понять',
      ),
      MetaskillDetailed(
        id: 'self_regulation',
        title: 'Саморегуляция',
        emoji: '🧘',
        domain: MetaskillDomain.emotional,
        description: 'Контроль над своими импульсами, эмоциями и поведением',
        currentLevel: 70,
        howToImprove: [
          'Практикуйте техники дыхания',
          'Делайте паузы перед реакцией',
          'Медитируйте регулярно',
        ],
        shortTip: 'Сделайте 3 глубоких вдоха',
      ),
      MetaskillDetailed(
        id: 'stress_resilience',
        title: 'Стрессоустойчивость',
        emoji: '💪',
        domain: MetaskillDomain.emotional,
        description: 'Способность эффективно справляться со стрессом и давлением',
        currentLevel: 62,
        howToImprove: [
          'Тренируйтесь на стрессовых сценариях',
          'Развивайте копинг-стратегии',
          'Заботьтесь о физическом здоровье',
        ],
        shortTip: 'Стресс — это вызов, не угроза',
      ),

      // Практические (4)
      MetaskillDetailed(
        id: 'adaptability',
        title: 'Адаптивность',
        emoji: '⚡',
        domain: MetaskillDomain.practical,
        description: 'Гибкость в изменении подхода при новых обстоятельствах',
        currentLevel: 80,
        howToImprove: [
          'Выходите из зоны комфорта',
          'Пробуйте новые P2P сценарии',
          'Экспериментируйте с подходами',
        ],
        shortTip: 'Принимайте перемены как возможность',
      ),
      MetaskillDetailed(
        id: 'time_management',
        title: 'Тайм-менеджмент',
        emoji: '⏰',
        domain: MetaskillDomain.practical,
        description: 'Эффективное планирование и использование времени',
        currentLevel: 55,
        howToImprove: [
          'Используйте технику Pomodoro',
          'Приоритизируйте задачи (матрица Эйзенхауэра)',
          'Отслеживайте, куда уходит время',
        ],
        shortTip: 'Планируйте вечером на завтра',
      ),
      MetaskillDetailed(
        id: 'goal_setting',
        title: 'Целеполагание',
        emoji: '🎯',
        domain: MetaskillDomain.practical,
        description: 'Умение ставить четкие, достижимые цели и следовать им',
        currentLevel: 73,
        howToImprove: [
          'Используйте SMART-критерии',
          'Разбивайте большие цели на шаги',
          'Отслеживайте прогресс еженедельно',
        ],
        shortTip: 'Запишите цель и крайний срок',
      ),
      MetaskillDetailed(
        id: 'problem_solving',
        title: 'Решение проблем',
        emoji: '🔧',
        domain: MetaskillDomain.practical,
        description: 'Систематический подход к преодолению препятствий',
        currentLevel: 78,
        howToImprove: [
          'Практикуйтесь на реальных кейсах в P2P',
          'Изучайте фреймворки (5 Whys, Fishbone)',
          'Анализируйте проблемы с разных сторон',
        ],
        shortTip: 'Определите корень, не симптом',
      ),
    ];
  }

  static List<MetaskillDetailed> getByDomain(MetaskillDomain domain) {
    return getAll16Skills().where((skill) => skill.domain == domain).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'emoji': emoji,
      'domain': domain.name,
      'description': description,
      'currentLevel': currentLevel,
      'howToImprove': howToImprove,
      'shortTip': shortTip,
    };
  }
}
