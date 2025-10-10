import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '11_celebration_screen.dart';

class SpheresAssessmentNewScreen extends StatefulWidget {
  const SpheresAssessmentNewScreen({super.key});

  @override
  State<SpheresAssessmentNewScreen> createState() =>
      _SpheresAssessmentNewScreenState();
}

class _SpheresAssessmentNewScreenState
    extends State<SpheresAssessmentNewScreen> {
  final Map<String, int> _ratings = {
    'money': 5,
    'health': 5,
    'relationships': 5,
    'goals': 5,
    'psychology': 5,
    'development': 5,
    'creativity': 5,
    'meaning': 5,
  };

  final List<Map<String, String>> _spheres = [
    {
      'id': 'money',
      'emoji': '💰',
      'title': 'ДЕНЬГИ',
      'subtitle': 'Финансы, доходы, инвестиции',
    },
    {
      'id': 'health',
      'emoji': '🏥',
      'title': 'ЗДОРОВЬЕ',
      'subtitle': 'Физическое состояние, энергия',
    },
    {
      'id': 'relationships',
      'emoji': '💕',
      'title': 'ОТНОШЕНИЯ',
      'subtitle': 'Семья, друзья, партнер',
    },
    {
      'id': 'goals',
      'emoji': '🎯',
      'title': 'ЦЕЛИ',
      'subtitle': 'Карьера, амбиции, достижения',
    },
    {
      'id': 'psychology',
      'emoji': '🧠',
      'title': 'ПСИХОЛОГИЯ',
      'subtitle': 'Ментальное здоровье, эмоции',
    },
    {
      'id': 'development',
      'emoji': '📈',
      'title': 'РАЗВИТИЕ',
      'subtitle': 'Обучение, рост, новые навыки',
    },
    {
      'id': 'creativity',
      'emoji': '🎨',
      'title': 'ТВОРЧЕСТВО',
      'subtitle': 'Креатив, хобби, самовыражение',
    },
    {
      'id': 'meaning',
      'emoji': '🔮',
      'title': 'СМЫСЛ',
      'subtitle': 'Духовность, ценности, цель жизни',
    },
  ];

  bool _canComplete() {
    // Все 8 сфер должны быть оценены (по умолчанию все на 5, так что можно сразу)
    return true;
  }

  void _complete() {
    if (!_canComplete()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Оцени все 8 сфер'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // Переход к Celebration Screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const CelebrationScreen(),
      ),
    );
  }

  Color _getSliderColor(int value) {
    if (value <= 3) return AppColors.error; // Красный
    if (value <= 6) return AppColors.accentOrange; // Желтый/оранжевый
    return AppColors.success; // Зеленый
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Заголовок
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🎯 Финальная задача Уровня 1!',
                    style: AppTextStyles.h1.copyWith(fontSize: 26),
                  ).animate().fadeIn(duration: 400.ms).slideY(
                        begin: -0.2,
                        end: 0,
                        duration: 400.ms,
                      ),
                  const SizedBox(height: 12),
                  Text(
                    'Оцени каждую сферу жизни от 0 до 10',
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white60,
                    ),
                  ).animate(delay: 200.ms).fadeIn(duration: 400.ms),
                  const SizedBox(height: 8),
                  Text(
                    '0 = провал, 10 = всё супер',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white60,
                    ),
                  ).animate(delay: 300.ms).fadeIn(duration: 400.ms),
                ],
              ),
            ),

            // Список сфер
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: _spheres.length,
                itemBuilder: (context, index) {
                  final sphere = _spheres[index];
                  final sphereId = sphere['id']!;
                  final rating = _ratings[sphereId]!;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: _buildSphereSlider(
                      emoji: sphere['emoji']!,
                      title: sphere['title']!,
                      subtitle: sphere['subtitle']!,
                      value: rating,
                      onChanged: (value) {
                        setState(() {
                          _ratings[sphereId] = value.round();
                        });
                      },
                    ),
                  )
                      .animate(delay: (400 + index * 80).ms)
                      .fadeIn(duration: 400.ms)
                      .slideX(begin: -0.2, end: 0, duration: 400.ms);
                },
              ),
            ),

            // Прогресс
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.success,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Прогресс: 8/8 сфер оценено ✓',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Кнопка завершения
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _complete,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Завершить Уровень 1',
                        style: AppTextStyles.h3.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSphereSlider({
    required String emoji,
    required String title,
    required String subtitle,
    required int value,
    required ValueChanged<double> onChanged,
  }) {
    final sliderColor = _getSliderColor(value);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: sliderColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.h3.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
              // Значение
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: sliderColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: sliderColor,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    value.toString(),
                    style: AppTextStyles.h2.copyWith(
                      color: sliderColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Слайдер
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: sliderColor,
              inactiveTrackColor: sliderColor.withOpacity(0.2),
              thumbColor: sliderColor,
              overlayColor: sliderColor.withOpacity(0.2),
              trackHeight: 8,
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 12,
              ),
            ),
            child: Slider(
              value: value.toDouble(),
              min: 0,
              max: 10,
              divisions: 10,
              onChanged: onChanged,
            ),
          ),

          // Подписи
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0 - Совсем плохо',
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white60,
                ),
              ),
              Text(
                '10 - Отлично',
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
