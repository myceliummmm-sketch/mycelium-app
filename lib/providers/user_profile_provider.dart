import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../models/test_result.dart';

// Provider для управления профилем пользователя
class UserProfileProvider extends ChangeNotifier {
  UserProfile _profile = UserProfile.initial(name: 'Пользователь');

  UserProfile get profile => _profile;

  // Обновить весь профиль
  void updateProfile(UserProfile newProfile) {
    _profile = newProfile;
    notifyListeners();
  }

  // Установить имя
  void setName(String name) {
    _profile = UserProfile(
      name: name,
      testResult: _profile.testResult,
      totalXP: _profile.totalXP,
      currentLevel: _profile.currentLevel,
      spheres: _profile.spheres,
    );
    notifyListeners();
  }

  // Завершить тесты
  void completeTests(TestResult result) {
    _profile = _profile.completeTests(result);
    notifyListeners();
  }

  // Добавить XP
  void addXP(int xp, {String? sphereId}) {
    _profile = _profile.addXP(xp, sphereId: sphereId);
    notifyListeners();
  }

  // Обновить рейтинг сферы
  void updateSphereRating(String sphereId, int rating) {
    _profile = _profile.updateSphereRating(sphereId, rating);
    notifyListeners();
  }

  // Сбросить профиль (для тестирования)
  void reset() {
    _profile = UserProfile.initial(name: 'Пользователь');
    notifyListeners();
  }
}
