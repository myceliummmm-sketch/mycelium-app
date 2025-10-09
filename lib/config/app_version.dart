/// App version configuration
class AppVersion {
  static const String version = '1.0.11';
  static const int buildNumber = 11;

  /// Full version string with build number
  static String get fullVersion => 'v$version+$buildNumber';

  /// Display version (without build number)
  static String get displayVersion => 'v$version';

  /// Release notes for this version
  static const String releaseNotes = '''
🚀 Версия 1.0.11 - Финальная полировка UI

Что нового:
✅ Radar диаграмма метаскилов увеличена - лучшая читаемость
✅ Метаскилы теперь кликабельны - открывается детальная информация
✅ Исправлена точность tap detection в Life Wheel
✅ P2P карточка улучшена - однородная заливка, текст не обрезается
✅ TODO карточки с чекбоксами в Сферах и Скилах

Фокус: Отполированный UI, точные клики, удобная навигация
  ''';
}
