import 'dart:math' as math;

enum LevelTier {
  spore('Спора', '🌰', 1, 10, 0),
  hypha('Гифа', '🌱', 11, 25, 100),
  primaryMycelium('Первичный мицелий', '🕸️', 26, 50, 500),
  fruitingBody('Плодовое тело', '🍄', 51, 75, 2000),
  symbiont('Симбионт', '🌳', 76, 90, 5000),
  motherMycelium('Материнская грибница', '✨', 91, 100, 10000);

  final String title;
  final String emoji;
  final int minLevel;
  final int maxLevel;
  final int xpRequired;

  const LevelTier(
    this.title,
    this.emoji,
    this.minLevel,
    this.maxLevel,
    this.xpRequired,
  );

  static LevelTier fromLevel(int level) {
    if (level <= 10) return LevelTier.spore;
    if (level <= 25) return LevelTier.hypha;
    if (level <= 50) return LevelTier.primaryMycelium;
    if (level <= 75) return LevelTier.fruitingBody;
    if (level <= 90) return LevelTier.symbiont;
    return LevelTier.motherMycelium;
  }

  List<String> get privileges {
    switch (this) {
      case LevelTier.spore:
        return ['Базовый матчинг', '3 сессии/неделю'];
      case LevelTier.hypha:
        return ['5 сессий/неделю', '50% сценариев'];
      case LevelTier.primaryMycelium:
        return ['10 сессий/неделю', '75% сценариев', 'Приоритет в матчинге'];
      case LevelTier.fruitingBody:
        return [
          'Безлимит сессий',
          'Все сценарии',
          'Может быть ментором',
          '2x MYC за менторство'
        ];
      case LevelTier.symbiont:
        return [
          'Создание сценариев',
          'Модерация',
          '3x MYC за активности'
        ];
      case LevelTier.motherMycelium:
        return [
          'Амбассадор платформы',
          'Участие в governance',
          'Процент от рефералов'
        ];
    }
  }
}

class UserLevel {
  final int currentLevel;
  final int currentXP;
  final int xpToNextLevel;
  final double progress;
  final LevelTier tier;

  UserLevel({
    required this.currentLevel,
    required this.currentXP,
    required this.xpToNextLevel,
    required this.progress,
    required this.tier,
  });

  factory UserLevel.fromXP(int xp) {
    final level = _calculateLevel(xp);
    final tier = LevelTier.fromLevel(level);
    final xpToNext = _calculateXPForNextLevel(level);
    final currentLevelXP = _calculateXPForLevel(level);
    final progress = (xp - currentLevelXP) / (xpToNext - currentLevelXP);

    return UserLevel(
      currentLevel: level,
      currentXP: xp,
      xpToNextLevel: xpToNext,
      progress: progress.clamp(0.0, 1.0),
      tier: tier,
    );
  }

  static int _calculateLevel(int xp) {
    // Simple formula: level = sqrt(xp / 100) + 1
    return math.sqrt(xp / 100).floor() + 1;
  }

  static int _calculateXPForLevel(int level) {
    return ((level - 1) * (level - 1) * 100).toInt();
  }

  static int _calculateXPForNextLevel(int level) {
    return (level * level * 100).toInt();
  }
}

// XP награды за действия
class XPReward {
  static const int sessionCompleted = 10;
  static const int highRating = 5;
  static const int mentorSession = 20;
  static const int goalAchieved = 50;
  static const int friendInvited = 30;
}
