import 'package:flutter/material.dart';

// Прогресс в одной сфере жизни

class SphereProgress {
  final String id;
  final String name;
  final String emoji;
  final String description;
  final int userRating; // 0-10 из assessment
  final int level; // На каком уровне открывается (1-5)
  final bool isUnlocked;
  final int currentXP; // XP в этой сфере
  final int requiredXP; // XP для разблокировки следующей
  final List<String> skills; // Навыки которые развиваются
  final Color color;

  SphereProgress({
    required this.id,
    required this.name,
    required this.emoji,
    required this.description,
    required this.userRating,
    required this.level,
    required this.isUnlocked,
    this.currentXP = 0,
    required this.requiredXP,
    required this.skills,
    required this.color,
  });

  // Процент прогресса до разблокировки
  double get progressPercent {
    if (isUnlocked) return 1.0;
    return currentXP / requiredXP;
  }

  // Сколько XP осталось
  int get remainingXP {
    return requiredXP - currentXP;
  }

  // Копия с изменениями
  SphereProgress copyWith({
    int? userRating,
    bool? isUnlocked,
    int? currentXP,
  }) {
    return SphereProgress(
      id: id,
      name: name,
      emoji: emoji,
      description: description,
      userRating: userRating ?? this.userRating,
      level: level,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      currentXP: currentXP ?? this.currentXP,
      requiredXP: requiredXP,
      skills: skills,
      color: color,
    );
  }

  // Фабрика для создания всех 8 сфер
  static List<SphereProgress> createAll8Spheres({
    Map<String, int>? ratings, // рейтинги из assessment
  }) {
    return [
      // УРОВЕНЬ 1 - Открыта с самого начала
      SphereProgress(
        id: 'money',
        name: 'Деньги',
        emoji: '💰',
        description: 'Финансы, доходы, инвестиции',
        userRating: ratings?['money'] ?? 5,
        level: 1,
        isUnlocked: true, // Открыта сразу
        currentXP: 0,
        requiredXP: 50, // Для следующей сферы
        skills: ['Переговоры', 'Ценообразование', 'Финансовая грамотность'],
        color: const Color(0xFFF59E0B),
      ),

      // УРОВЕНЬ 2
      SphereProgress(
        id: 'relationships',
        name: 'Отношения',
        emoji: '💕',
        description: 'Семья, друзья, партнер',
        userRating: ratings?['relationships'] ?? 5,
        level: 2,
        isUnlocked: false,
        currentXP: 0,
        requiredXP: 50,
        skills: ['Эмпатия', 'Коммуникация', 'Влияние'],
        color: const Color(0xFFEC4899),
      ),

      // УРОВЕНЬ 3
      SphereProgress(
        id: 'goals',
        name: 'Цели',
        emoji: '🎯',
        description: 'Карьера, амбиции, достижения',
        userRating: ratings?['goals'] ?? 5,
        level: 3,
        isUnlocked: false,
        currentXP: 0,
        requiredXP: 100,
        skills: ['Целеполагание', 'Планирование', 'Фокус'],
        color: const Color(0xFF6366F1),
      ),

      SphereProgress(
        id: 'health',
        name: 'Здоровье',
        emoji: '🏥',
        description: 'Физическое состояние, энергия',
        userRating: ratings?['health'] ?? 5,
        level: 3,
        isUnlocked: false,
        currentXP: 0,
        requiredXP: 100,
        skills: ['Энергия', 'Стрессоустойчивость', 'Режим'],
        color: const Color(0xFF10B981),
      ),

      // УРОВЕНЬ 4
      SphereProgress(
        id: 'psychology',
        name: 'Психология',
        emoji: '🧠',
        description: 'Ментальное здоровье, эмоции',
        userRating: ratings?['psychology'] ?? 5,
        level: 4,
        isUnlocked: false,
        currentXP: 0,
        requiredXP: 150,
        skills: ['Саморегуляция', 'Эмоциональный интеллект', 'Осознанность'],
        color: const Color(0xFF8B5CF6),
      ),

      SphereProgress(
        id: 'development',
        name: 'Развитие',
        emoji: '📈',
        description: 'Обучение, рост, новые навыки',
        userRating: ratings?['development'] ?? 5,
        level: 4,
        isUnlocked: false,
        currentXP: 0,
        requiredXP: 150,
        skills: ['Обучаемость', 'Критическое мышление', 'Адаптивность'],
        color: const Color(0xFF3B82F6),
      ),

      SphereProgress(
        id: 'creativity',
        name: 'Творчество',
        emoji: '🎨',
        description: 'Креатив, хобби, самовыражение',
        userRating: ratings?['creativity'] ?? 5,
        level: 4,
        isUnlocked: false,
        currentXP: 0,
        requiredXP: 150,
        skills: ['Креативность', 'Латеральное мышление', 'Эстетика'],
        color: const Color(0xFFFBBF24),
      ),

      // УРОВЕНЬ 5
      SphereProgress(
        id: 'meaning',
        name: 'Смысл',
        emoji: '🔮',
        description: 'Духовность, ценности, цель жизни',
        userRating: ratings?['meaning'] ?? 5,
        level: 5,
        isUnlocked: false,
        currentXP: 0,
        requiredXP: 200,
        skills: ['Рефлексия', 'Ценности', 'Цель жизни'],
        color: const Color(0xFFA855F7),
      ),
    ];
  }
}
