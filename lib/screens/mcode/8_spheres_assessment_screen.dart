import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/user_profile_provider.dart';
import '../../models/sphere_progress.dart';
import '9_mcode_dashboard_screen.dart';

class SpheresAssessmentScreen extends StatefulWidget {
  const SpheresAssessmentScreen({super.key});

  @override
  State<SpheresAssessmentScreen> createState() => _SpheresAssessmentScreenState();
}

class _SpheresAssessmentScreenState extends State<SpheresAssessmentScreen> {
  final Map<String, int> _ratings = {
    'money': 5,
    'relationships': 5,
    'goals': 5,
    'health': 5,
    'psychology': 5,
    'development': 5,
    'creativity': 5,
    'meaning': 5,
  };

  void _complete() {
    final provider = context.read<UserProfileProvider>();

    // Обновляем рейтинги всех сфер
    _ratings.forEach((sphereId, rating) {
      provider.updateSphereRating(sphereId, rating);
    });

    // Переходим к дашборду
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const MCodeDashboardScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Получаем все сферы для отображения
    final spheres = SphereProgress.createAll8Spheres();

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
            // Хедер
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Прогресс
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: 5 / 6, // Шаг 5 из 6
                          backgroundColor: Colors.white.withOpacity(0.1),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryPurple,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '5/6',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Заголовок
                  Text(
                    'Оцени свою жизнь',
                    style: AppTextStyles.h1,
                  ).animate()
                    .fadeIn(duration: 400.ms)
                    .slideX(begin: -0.2, end: 0, duration: 400.ms),

                  const SizedBox(height: 12),

                  Text(
                    'По шкале от 0 до 10 оцени каждую сферу',
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white60,
                    ),
                  ).animate()
                    .fadeIn(delay: 200.ms, duration: 400.ms)
                    .slideX(begin: -0.2, end: 0, delay: 200.ms, duration: 400.ms),
                ],
              ),
            ),

            // Список сфер
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: spheres.length,
                itemBuilder: (context, index) {
                  final sphere = spheres[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: _SphereSlider(
                      sphere: sphere,
                      value: _ratings[sphere.id]!,
                      onChanged: (value) {
                        setState(() {
                          _ratings[sphere.id] = value;
                        });
                      },
                    ).animate()
                      .fadeIn(delay: (300 + index * 80).ms, duration: 400.ms)
                      .slideX(
                        begin: -0.2,
                        end: 0,
                        delay: (300 + index * 80).ms,
                        duration: 400.ms,
                      ),
                  );
                },
              ),
            ),

            // Кнопка завершить
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
                  child: Text(
                    'Завершить',
                    style: AppTextStyles.h3.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SphereSlider extends StatelessWidget {
  final SphereProgress sphere;
  final int value;
  final ValueChanged<int> onChanged;

  const _SphereSlider({
    required this.sphere,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: sphere.color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок сферы
          Row(
            children: [
              Text(
                sphere.emoji,
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sphere.name,
                      style: AppTextStyles.h3.copyWith(fontSize: 18),
                    ),
                    Text(
                      sphere.description,
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
              // Текущее значение
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: sphere.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: sphere.color,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    value.toString(),
                    style: AppTextStyles.h2.copyWith(
                      color: sphere.color,
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
              activeTrackColor: sphere.color,
              inactiveTrackColor: sphere.color.withOpacity(0.2),
              thumbColor: sphere.color,
              overlayColor: sphere.color.withOpacity(0.2),
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
              onChanged: (double newValue) {
                onChanged(newValue.round());
              },
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
