import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/user_profile_provider.dart';
import '10_spheres_assessment_screen.dart';

class NewMCodeDashboardScreen extends StatefulWidget {
  const NewMCodeDashboardScreen({super.key});

  @override
  State<NewMCodeDashboardScreen> createState() => _NewMCodeDashboardScreenState();
}

class _NewMCodeDashboardScreenState extends State<NewMCodeDashboardScreen> {
  bool _isProfileExpanded = false;
  bool _isLevel1Expanded = true; // Уровень 1 раскрыт по умолчанию
  final Map<int, bool> _levelExpanded = {
    2: false,
    3: false,
    4: false,
    5: false,
    6: false,
    7: false,
    8: false,
  };

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<UserProfileProvider>().profile;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            // Заголовок
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Text(
                    '🍄 mCode',
                    style: AppTextStyles.h1.copyWith(fontSize: 28),
                  ),
                ],
              ),
            ),

            // Контент со скроллом
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Карточка профиля
                    _buildProfileCard(profile),

                    const SizedBox(height: 32),

                    // Заголовок "Твой путь роста"
                    Text(
                      '🎯 ТВОЙ ПУТЬ РОСТА',
                      style: AppTextStyles.h2.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Проходи уровни по порядку\nОткрывай новые сферы',
                      style: AppTextStyles.body.copyWith(
                        color: Colors.white60,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Уровень 1 (Активный)
                    _buildLevel1(),

                    const SizedBox(height: 16),

                    // Уровни 2-8 (Заблокированы)
                    ...List.generate(7, (index) {
                      final level = index + 2;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildLockedLevel(level),
                      );
                    }),

                    const SizedBox(height: 24),

                    // P2P секция
                    _buildP2PSection(),

                    const SizedBox(height: 100), // Отступ для нижнего меню
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(dynamic profile) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isProfileExpanded = !_isProfileExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryPurple.withOpacity(0.2),
              AppColors.accentBlue.withOpacity(0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primaryPurple.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Минимизированная версия
            Row(
              children: [
                Text(
                  '👤',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Стратег-Визионер',
                        style: AppTextStyles.h3,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Уровень 1 • 30/100 XP',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white60,
                        ),
                      ),
                      Text(
                        '💎 150 MYC',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  _isProfileExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.white60,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Прогресс бар
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: 0.3,
                backgroundColor: Colors.white.withOpacity(0.1),
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primaryPurple,
                ),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '30%',
              style: AppTextStyles.caption.copyWith(
                color: Colors.white60,
              ),
            ),

            // Развернутая версия
            if (_isProfileExpanded) ...[
              const SizedBox(height: 20),
              Divider(color: Colors.white.withOpacity(0.1)),
              const SizedBox(height: 16),

              Text(
                '📊 МОЙ ПРОФИЛЬ',
                style: AppTextStyles.h3,
              ),
              const SizedBox(height: 12),

              _buildProfileRow('🎭 Тип:', 'Стратег-Визионер'),
              _buildProfileRow('DISC:', 'D (Лидер)'),

              const SizedBox(height: 12),
              Text(
                'Big Five:',
                style: AppTextStyles.body.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
              _buildProfileRow('• Openness:', 'High', indent: true),
              _buildProfileRow('• Conscientiousness:', 'Medium', indent: true),
              _buildProfileRow('• Extraversion:', 'High', indent: true),
              _buildProfileRow('• Agreeableness:', 'Low', indent: true),
              _buildProfileRow('• Neuroticism:', 'Low', indent: true),

              const SizedBox(height: 12),
              Text(
                'Приоритетные сферы:',
                style: AppTextStyles.body.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '💰 Деньги • 💕 Отношения • 🎯 Цели',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.accent,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow(String label, String value, {bool indent = false}) {
    return Padding(
      padding: EdgeInsets.only(left: indent ? 12 : 0, bottom: 4),
      child: Row(
        children: [
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: Colors.white60,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: AppTextStyles.caption.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevel1() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isLevel1Expanded = !_isLevel1Expanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primaryPurple.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок уровня
            Row(
              children: [
                Icon(
                  _isLevel1Expanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  color: AppColors.primaryPurple,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'УРОВЕНЬ 1 • АКТИВЕН',
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.primaryPurple,
                    ),
                  ),
                ),
              ],
            ),

            if (_isLevel1Expanded) ...[
              const SizedBox(height: 20),

              // Сфера
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text('💰', style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ДЕНЬГИ',
                            style: AppTextStyles.h3.copyWith(fontSize: 16),
                          ),
                          Text(
                            '(оценка появится после задачи №4)',
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '✅ Разблокировано',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Задачи
              Text(
                '📋 ТВОИ ЗАДАЧИ:',
                style: AppTextStyles.h3,
              ),
              const SizedBox(height: 16),

              // Задача 1 - Завершена
              _buildTask(
                icon: '✅',
                title: 'Узнать свой DISC тип',
                subtitle: 'Готово! +10 XP',
                isCompleted: true,
              ),

              const SizedBox(height: 12),

              // Задача 2 - Завершена
              _buildTask(
                icon: '✅',
                title: 'Пройти Big Five тест',
                subtitle: 'Готово! +10 XP',
                isCompleted: true,
              ),

              const SizedBox(height: 12),

              // Задача 3 - Завершена
              _buildTask(
                icon: '✅',
                title: 'Выбрать 3 приоритета',
                subtitle: 'Готово! +10 XP',
                isCompleted: true,
              ),

              const SizedBox(height: 12),

              // Задача 4 - Активная
              _buildTask(
                icon: '⬜',
                title: 'Оценить 8 сфер баланса',
                subtitle: 'Последняя задача! +70 XP',
                isCompleted: false,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SpheresAssessmentNewScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              // Подсказка
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.info.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('💡', style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Подсказка:',
                            style: AppTextStyles.body.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Оцени каждую сферу жизни от 0 до 10\nЭто поможет построить твой профиль',
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Divider(color: Colors.white.withOpacity(0.1)),

              const SizedBox(height: 16),

              // Прогресс уровня
              Text(
                'Прогресс уровня: 30/100 XP',
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: 0.3,
                  backgroundColor: Colors.white.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primaryPurple,
                  ),
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '30%',
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white60,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTask({
    required String icon,
    required String title,
    required String subtitle,
    required bool isCompleted,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: isCompleted ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isCompleted
              ? Colors.white.withOpacity(0.03)
              : AppColors.primaryPurple.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isCompleted
                ? Colors.white.withOpacity(0.1)
                : AppColors.primaryPurple.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isCompleted ? Colors.white60 : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.caption.copyWith(
                      color: isCompleted
                          ? Colors.white.withOpacity(0.4)
                          : AppColors.accent,
                    ),
                  ),
                ],
              ),
            ),
            if (!isCompleted)
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.primaryPurple,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLockedLevel(int level) {
    final isExpanded = _levelExpanded[level] ?? false;
    final levelData = _getLevelData(level);

    return GestureDetector(
      onTap: () {
        setState(() {
          _levelExpanded[level] = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок
            Row(
              children: [
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  color: Colors.white60,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'УРОВЕНЬ $level • 🔒 ЗАБЛОКИРОВАН',
                    style: AppTextStyles.h3.copyWith(
                      color: Colors.white60,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Условия разблокировки
            Text(
              'Откроется при:',
              style: AppTextStyles.caption.copyWith(
                color: Colors.white60,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '• ${levelData['xpRequired']} XP (сейчас: 30/${levelData['xpRequired']})',
              style: AppTextStyles.caption.copyWith(
                color: Colors.white.withOpacity(0.4),
              ),
            ),
            Text(
              '• Все задачи Уровня ${level - 1}',
              style: AppTextStyles.caption.copyWith(
                color: Colors.white.withOpacity(0.4),
              ),
            ),

            if (isExpanded) ...[
              const SizedBox(height: 16),
              Divider(color: Colors.white.withOpacity(0.1)),
              const SizedBox(height: 16),

              // Превью сферы
              Row(
                children: [
                  Text(levelData['emoji'], style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${levelData['sphere']} - ?/10',
                          style: AppTextStyles.body.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white60,
                          ),
                        ),
                        Text(
                          '🔒 Locked',
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white.withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Что будет внутри
              Text(
                'Что будет внутри:',
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white60,
                ),
              ),
              const SizedBox(height: 12),

              Text(
                '📋 ЗАДАЧИ:',
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white60,
                ),
              ),
              const SizedBox(height: 8),

              ...List.generate(levelData['tasks'].length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    '⬜ ${levelData['tasks'][index]}',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 12),

              // Прогресс
              Text(
                'Прогресс: 0/${levelData['xpRequired']} XP',
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white60,
                ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: 0,
                  backgroundColor: Colors.white.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white.withOpacity(0.2),
                  ),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '0%',
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getLevelData(int level) {
    final data = {
      2: {
        'emoji': '💕',
        'sphere': 'ОТНОШЕНИЯ',
        'xpRequired': 150,
        'tasks': [
          'Тест "Эмпатия"',
          'Тест "Коммуникация"',
          'Тест "Конфликты"',
          'Поставить цель',
        ],
      },
      3: {
        'emoji': '🎯',
        'sphere': 'ЦЕЛИ',
        'xpRequired': 200,
        'tasks': [
          'Тест "Мотивация"',
          'Тест "Фокус"',
          'Тест "Достижения"',
          'Поставить цель',
        ],
      },
      4: {
        'emoji': '🏥',
        'sphere': 'ЗДОРОВЬЕ',
        'xpRequired': 250,
        'tasks': [
          'Тест "Энергия"',
          'Тест "Привычки"',
          'Тест "Стресс"',
          'Поставить цель',
        ],
      },
      5: {
        'emoji': '🧠',
        'sphere': 'ПСИХОЛОГИЯ',
        'xpRequired': 300,
        'tasks': [
          'Тест "Эмоции"',
          'Тест "Тревожность"',
          'Тест "Осознанность"',
          'Поставить цель',
        ],
      },
      6: {
        'emoji': '📈',
        'sphere': 'РАЗВИТИЕ',
        'xpRequired': 350,
        'tasks': [
          'Тест "Обучаемость"',
          'Тест "Навыки"',
          'Тест "Знания"',
          'Поставить цель',
        ],
      },
      7: {
        'emoji': '🎨',
        'sphere': 'ТВОРЧЕСТВО',
        'xpRequired': 400,
        'tasks': [
          'Тест "Креативность"',
          'Тест "Самовыражение"',
          'Тест "Хобби"',
          'Поставить цель',
        ],
      },
      8: {
        'emoji': '🔮',
        'sphere': 'СМЫСЛ',
        'xpRequired': 450,
        'tasks': [
          'Тест "Ценности"',
          'Тест "Духовность"',
          'Тест "Цель жизни"',
          'Поставить цель',
        ],
      },
    };

    return data[level]!;
  }

  Widget _buildP2PSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.accentOrange.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🎮 P2P ТРЕНИРОВКИ',
            style: AppTextStyles.h2.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.accentOrange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.lock,
                  color: AppColors.accentOrange,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Разблокируется на уровне 5',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.accentOrange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Text(
            'Живая практика с реальными людьми\nРолевые игры для твоих целей\nAI-анализ после каждой сессии',
            style: AppTextStyles.body.copyWith(
              color: Colors.white60,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            'Твой путь:',
            style: AppTextStyles.caption.copyWith(
              color: Colors.white60,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: 0.2,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.accentOrange,
              ),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '1/5',
            style: AppTextStyles.caption.copyWith(
              color: Colors.white60,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            'Что нужно для разблокировки:',
            style: AppTextStyles.body.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),

          _buildChecklistItem('☐ Достичь уровня 5 (400+ XP)', false),
          _buildChecklistItem('☐ Пройти все 5 уровней', false),
          _buildChecklistItem('☐ Trust Score минимум 50', false),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Показать модалку с подробностями о P2P
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentOrange.withOpacity(0.2),
                foregroundColor: AppColors.accentOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Узнать больше',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.accentOrange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(String text, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: AppTextStyles.caption.copyWith(
          color: isCompleted ? AppColors.success : Colors.white60,
        ),
      ),
    );
  }
}
