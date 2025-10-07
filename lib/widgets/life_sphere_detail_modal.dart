import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/life_sphere.dart';
import '../theme/app_theme.dart';

class LifeSphereDetailModal extends StatelessWidget {
  final LifeSphere sphere;
  final double currentValue;

  const LifeSphereDetailModal({
    super.key,
    required this.sphere,
    required this.currentValue,
  });

  static void show(BuildContext context, LifeSphere sphere, double value) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => LifeSphereDetailModal(
        sphere: sphere,
        currentValue: value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A1F3A), AppColors.background],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Emoji and title
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: sphere.color.withOpacity(0.2),
                      border: Border.all(
                        color: sphere.color,
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        sphere.emoji,
                        style: const TextStyle(fontSize: 48),
                      ),
                    ),
                  )
                      .animate()
                      .scale(duration: 500.ms, curve: Curves.elasticOut),

                  const SizedBox(height: 24),

                  Text(
                    sphere.title,
                    style: AppTextStyles.h1,
                    textAlign: TextAlign.center,
                  ).animate(delay: 100.ms).fadeIn(),

                  const SizedBox(height: 24),

                  // Current value
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          sphere.color.withOpacity(0.3),
                          sphere.color.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: sphere.color.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Текущий балл',
                          style: AppTextStyles.caption,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${currentValue.toInt()}/100',
                          style: AppTextStyles.h1.copyWith(
                            fontSize: 36,
                            color: sphere.color,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: currentValue / 100,
                            minHeight: 8,
                            backgroundColor: Colors.white.withOpacity(0.1),
                            valueColor: AlwaysStoppedAnimation(sphere.color),
                          ),
                        ),
                      ],
                    ),
                  ).animate(delay: 150.ms).fadeIn().scale(),

                  const SizedBox(height: 24),

                  // Tips to improve
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: AppDecorations.cardBackground,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              '💡',
                              style: TextStyle(fontSize: 24),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Как улучшить',
                              style: AppTextStyles.h3,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ..._getTipsForSphere(sphere.name)
                            .asMap()
                            .entries
                            .map((entry) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  margin: const EdgeInsets.only(top: 2),
                                  decoration: BoxDecoration(
                                    color: sphere.color.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${entry.key + 1}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: sphere.color,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    entry.value,
                                    style: AppTextStyles.body,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 24),

                  // Action button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: Navigate to training for this sphere
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: sphere.color,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Начать тренировку',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ).animate(delay: 250.ms).fadeIn().slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getTipsForSphere(String sphereName) {
    switch (sphereName) {
      case 'career':
        return [
          'Поставь конкретные цели на квартал',
          'Проси обратную связь у коллег',
          'Развивай новые навыки регулярно',
          'Выстраивай связи в профессиональном сообществе',
        ];
      case 'finance':
        return [
          'Веди учет доходов и расходов',
          'Создай финансовую подушку безопасности',
          'Инвестируй в свое образование',
          'Планируй крупные покупки заранее',
        ];
      case 'health':
        return [
          'Спи не менее 7-8 часов в день',
          'Регулярные физические нагрузки 3-4 раза в неделю',
          'Следи за питанием и водным балансом',
          'Проходи ежегодные медицинские осмотры',
        ];
      case 'relationships':
        return [
          'Уделяй качественное время близким',
          'Говори о своих чувствах открыто',
          'Находи компромиссы в конфликтах',
          'Практикуй благодарность и признание',
        ];
      case 'development':
        return [
          'Читай книги из разных областей',
          'Пробуй новые хобби и активности',
          'Рефлексируй над своими действиями',
          'Общайся с людьми из разных сфер',
        ];
      case 'social':
        return [
          'Планируй время для отдыха и развлечений',
          'Находи радость в простых вещах',
          'Пробуй новые активности и места',
          'Окружай себя позитивными людьми',
        ];
      case 'creativity':
        return [
          'Создай комфортное пространство дома',
          'Регулярно убирайся и организуй вещи',
          'Добавь растения и приятные детали',
          'Минимизируй отвлекающие факторы',
        ];
      case 'spirituality':
        return [
          'Практикуй медитацию или осознанность',
          'Изучай философию и смыслы жизни',
          'Проводи время наедине с собой',
          'Ищи вдохновение в природе и искусстве',
        ];
      default:
        return [
          'Уделяй этой сфере регулярное внимание',
          'Ставь конкретные цели',
          'Отслеживай прогресс',
          'Празднуй маленькие победы',
        ];
    }
  }
}
