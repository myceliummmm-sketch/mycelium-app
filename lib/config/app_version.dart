/// App version configuration
class AppVersion {
  static const String version = '0.7';
  static const int buildNumber = 7;

  /// Full version string with build number
  static String get fullVersion => 'v$version+$buildNumber';

  /// Display version (without build number)
  static String get displayVersion => 'v$version';

  /// Release notes for this version
  static const String releaseNotes = '''
🎉 Версия 1.0.0 - Первый стабильный релиз!

Что нового:
✅ Новый экран Community с Mycelium Week 🎯
✅ P2P сценарии для развития метаскилов
✅ AI-ассистент для персональных консультаций
✅ Тесты для оценки метаскилов
✅ Интеграция с Telegram Mini App
✅ Красивые анимации и визуализации

Это первая стабильная версия платформы Mycelium!
  ''';
}
