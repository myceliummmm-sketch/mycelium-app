import 'test_result.dart';
import 'sphere_progress.dart';

// Профиль пользователя - всё что мы знаем о нём

class UserProfile {
  final String name;
  final TestResult? testResult; // null пока не прошел тесты
  final int totalXP;
  final int currentLevel;
  final List<SphereProgress> spheres;

  UserProfile({
    required this.name,
    this.testResult,
    this.totalXP = 0,
    this.currentLevel = 1,
    required this.spheres,
  });

  // Процент прогресса до следующего уровня
  double get levelProgress {
    final xpForCurrentLevel = _getXPForLevel(currentLevel);
    final xpForNextLevel = _getXPForLevel(currentLevel + 1);
    final xpInCurrentLevel = totalXP - xpForCurrentLevel;
    final xpNeededForLevel = xpForNextLevel - xpForCurrentLevel;

    return xpInCurrentLevel / xpNeededForLevel;
  }

  // XP нужно для следующего уровня
  int get xpForNextLevel {
    return _getXPForLevel(currentLevel + 1) - totalXP;
  }

  // Сколько сфер разблокировано
  int get unlockedSpheresCount {
    return spheres.where((s) => s.isUnlocked).length;
  }

  // Открыт ли P2P
  bool get isP2PUnlocked {
    return currentLevel >= 5;
  }

  // Формула XP для каждого уровня
  static int _getXPForLevel(int level) {
    switch (level) {
      case 1:
        return 0;
      case 2:
        return 50;
      case 3:
        return 100;
      case 4:
        return 150;
      case 5:
        return 200;
      default:
        return 200 + (level - 5) * 100;
    }
  }

  // Добавить XP
  UserProfile addXP(int xp, {String? sphereId}) {
    final newTotalXP = totalXP + xp;
    final newLevel = _calculateLevel(newTotalXP);

    // Если указана сфера, добавляем XP и туда
    List<SphereProgress> newSpheres = spheres;
    if (sphereId != null) {
      newSpheres = spheres.map((sphere) {
        if (sphere.id == sphereId) {
          return sphere.copyWith(currentXP: sphere.currentXP + xp);
        }
        return sphere;
      }).toList();
    }

    // Проверяем разблокировки
    newSpheres = _checkUnlocks(newSpheres, newLevel);

    return UserProfile(
      name: name,
      testResult: testResult,
      totalXP: newTotalXP,
      currentLevel: newLevel,
      spheres: newSpheres,
    );
  }

  // Расчёт уровня по XP
  static int _calculateLevel(int xp) {
    if (xp < 50) return 1;
    if (xp < 100) return 2;
    if (xp < 150) return 3;
    if (xp < 200) return 4;
    return 5 + ((xp - 200) ~/ 100);
  }

  // Проверка разблокировок сфер
  List<SphereProgress> _checkUnlocks(
      List<SphereProgress> spheres, int level) {
    return spheres.map((sphere) {
      if (sphere.isUnlocked) return sphere;

      // Разблокируем если достигнут нужный уровень
      if (level >= sphere.level) {
        return sphere.copyWith(isUnlocked: true);
      }

      return sphere;
    }).toList();
  }

  // Обновить рейтинг сферы из assessment
  UserProfile updateSphereRating(String sphereId, int rating) {
    final newSpheres = spheres.map((sphere) {
      if (sphere.id == sphereId) {
        return sphere.copyWith(userRating: rating);
      }
      return sphere;
    }).toList();

    return UserProfile(
      name: name,
      testResult: testResult,
      totalXP: totalXP,
      currentLevel: currentLevel,
      spheres: newSpheres,
    );
  }

  // Завершить тесты
  UserProfile completeTests(TestResult result) {
    return UserProfile(
      name: name,
      testResult: result,
      totalXP: totalXP,
      currentLevel: currentLevel,
      spheres: spheres,
    );
  }

  // Создать начальный профиль
  factory UserProfile.initial({required String name}) {
    return UserProfile(
      name: name,
      testResult: null,
      totalXP: 0,
      currentLevel: 1,
      spheres: SphereProgress.createAll8Spheres(),
    );
  }
}
