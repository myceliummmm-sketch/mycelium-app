import 'package:flutter/material.dart';

enum LifeSphere {
  career('Карьера', '💼', Color(0xFF6366F1)),
  relationships('Отношения', '❤️', Color(0xFFEC4899)),
  finance('Финансы', '💰', Color(0xFF10B981)),
  health('Здоровье', '🏃', Color(0xFFF59E0B)),
  creativity('Творчество', '🎨', Color(0xFF8B5CF6)),
  development('Развитие', '📚', Color(0xFF3B82F6)),
  social('Социум', '👥', Color(0xFF14B8A6)),
  spirituality('Духовность', '🧘', Color(0xFFA855F7));

  final String title;
  final String emoji;
  final Color color;

  const LifeSphere(this.title, this.emoji, this.color);
}

class LifeSphereData {
  final LifeSphere sphere;
  final int value; // 0-100
  final double change; // изменение за последние 30 дней

  LifeSphereData({
    required this.sphere,
    required this.value,
    this.change = 0.0,
  });

  Color get statusColor {
    if (value >= 61) return const Color(0xFF10B981); // green
    if (value >= 31) return const Color(0xFFF59E0B); // yellow
    return const Color(0xFFEF4444); // red
  }

  String get statusText {
    if (value >= 61) return 'Отлично';
    if (value >= 31) return 'Хорошо';
    return 'Нужно внимание';
  }

  LifeSphereData copyWith({
    int? value,
    double? change,
  }) {
    return LifeSphereData(
      sphere: sphere,
      value: value ?? this.value,
      change: change ?? this.change,
    );
  }
}

class LifeWheelBalance {
  final List<LifeSphereData> spheres;
  final double averageBalance; // средний балл
  final double harmony; // гармоничность (минимальное отклонение)

  LifeWheelBalance({
    required this.spheres,
    required this.averageBalance,
    required this.harmony,
  });

  factory LifeWheelBalance.initial() {
    // Начальные значения - все по 50
    final spheres = LifeSphere.values
        .map((sphere) => LifeSphereData(sphere: sphere, value: 50))
        .toList();

    return LifeWheelBalance(
      spheres: spheres,
      averageBalance: 50.0,
      harmony: 1.0, // идеальная гармония в начале
    );
  }

  factory LifeWheelBalance.fromMockData() {
    // Более реалистичные моковые данные
    final spheres = [
      LifeSphereData(sphere: LifeSphere.career, value: 72, change: 5.0),
      LifeSphereData(
          sphere: LifeSphere.relationships, value: 58, change: -2.0),
      LifeSphereData(sphere: LifeSphere.finance, value: 65, change: 8.0),
      LifeSphereData(sphere: LifeSphere.health, value: 45, change: 0.0),
      LifeSphereData(sphere: LifeSphere.creativity, value: 38, change: -5.0),
      LifeSphereData(sphere: LifeSphere.development, value: 68, change: 12.0),
      LifeSphereData(sphere: LifeSphere.social, value: 55, change: 3.0),
      LifeSphereData(sphere: LifeSphere.spirituality, value: 42, change: 1.0),
    ];

    final average = spheres.map((s) => s.value).reduce((a, b) => a + b) / 8;
    final maxValue = spheres.map((s) => s.value).reduce((a, b) => a > b ? a : b);
    final minValue = spheres.map((s) => s.value).reduce((a, b) => a < b ? a : b);
    final harmony = 1 - ((maxValue - minValue) / 100);

    return LifeWheelBalance(
      spheres: spheres,
      averageBalance: average,
      harmony: harmony,
    );
  }
}
