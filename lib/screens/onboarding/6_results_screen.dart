import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bottom_navigation.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  bool _showResults = false;
  int _loadingStep = 0;

  final List<String> _loadingMessages = [
    '✓ Определил твой DISC тип',
    '✓ Рассчитал черты характера',
    '✓ Выявил приоритетные сферы',
    '✓ Нашел зоны роста',
    '💡 Собираю инсайты...',
  ];

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() {
    // Меняем сообщения каждые 1.6 сек (8 сек / 5 сообщений)
    Future.delayed(const Duration(milliseconds: 1600), () {
      if (mounted) {
        setState(() => _loadingStep = 1);
      }
    });
    Future.delayed(const Duration(milliseconds: 3200), () {
      if (mounted) {
        setState(() => _loadingStep = 2);
      }
    });
    Future.delayed(const Duration(milliseconds: 4800), () {
      if (mounted) {
        setState(() => _loadingStep = 3);
      }
    });
    Future.delayed(const Duration(milliseconds: 6400), () {
      if (mounted) {
        setState(() => _loadingStep = 4);
      }
    });
    Future.delayed(const Duration(milliseconds: 8000), () {
      if (mounted) {
        setState(() => _showResults = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_showResults) {
      return _buildLoadingScreen();
    }
    return _buildResultsScreen();
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Анимированный гриб
              Text(
                '🍄',
                style: const TextStyle(fontSize: 80),
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(),
                  )
                  .scale(
                    duration: 1500.ms,
                    begin: const Offset(1.0, 1.0),
                    end: const Offset(1.2, 1.2),
                    curve: Curves.easeInOut,
                  )
                  .then()
                  .scale(
                    duration: 1500.ms,
                    begin: const Offset(1.2, 1.2),
                    end: const Offset(1.0, 1.0),
                    curve: Curves.easeInOut,
                  ),

              const SizedBox(height: 40),

              // Спиннер
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryPurple),
              ),

              const SizedBox(height: 40),

              // Заголовок
              Text(
                '🔮 Анализирую твой профиль...',
                style: AppTextStyles.h2.copyWith(fontSize: 20),
              ),

              const SizedBox(height: 16),

              // Сменяющиеся сообщения
              SizedBox(
                height: 100,
                child: Column(
                  children: List.generate(
                    _loadingMessages.length,
                    (index) => AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: _loadingStep >= index ? 1.0 : 0.3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          _loadingMessages[index],
                          style: AppTextStyles.body.copyWith(
                            color: _loadingStep >= index
                                ? AppColors.success
                                : Colors.white60,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // "Готово! Смотри ↓"
              if (_loadingStep >= 4)
                Text(
                  'Готово! Смотри ↓',
                  style: AppTextStyles.h3.copyWith(
                    color: AppColors.success,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: 0.3, end: 0, duration: 500.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsScreen() {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Заголовок
              Text(
                '🎉 Поздравляем! Ты теперь часть Mycelium!',
                style: AppTextStyles.h1.copyWith(fontSize: 24),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ).animate().fadeIn(duration: 600.ms).slideY(
                    begin: -0.2,
                    end: 0,
                    duration: 600.ms,
                  ),

              const SizedBox(height: 8),

              Text(
                'Твоя грибница начала расти.',
                style: AppTextStyles.body.copyWith(
                  color: Colors.white60,
                  fontSize: 13,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ).animate(delay: 200.ms).fadeIn(duration: 400.ms),

              const SizedBox(height: 40),

              // Тип личности
              Container(
                padding: const EdgeInsets.all(16),
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
                    Text(
                      '🎭 Твой тип: СТРАТЕГ-ВИЗИОНЕР',
                      style: AppTextStyles.h2.copyWith(fontSize: 18),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Ты прирожденный лидер с нестандартным мышлением. Любишь вызовы и быстрые решения.',
                      style: AppTextStyles.body.copyWith(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
                  .animate(delay: 400.ms)
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: 0.2, end: 0, duration: 600.ms),

              const SizedBox(height: 20),

              // Суперсилы
              Text(
                '✨ СУПЕРСИЛЫ:',
                style: AppTextStyles.h3.copyWith(fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ).animate(delay: 600.ms).fadeIn(duration: 400.ms),

              const SizedBox(height: 16),

              _buildBulletPoint(
                '⚡ Решительность в критических ситуациях',
                800,
              ),
              _buildBulletPoint(
                '🎯 Видишь возможности где другие видят проблемы',
                900,
              ),
              _buildBulletPoint(
                '🚀 Не боишься рисковать и пробовать новое',
                1000,
              ),

              const SizedBox(height: 20),

              // Вызовы
              Text(
                '⚠️ ВЫЗОВЫ:',
                style: AppTextStyles.h3.copyWith(fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ).animate(delay: 1100.ms).fadeIn(duration: 400.ms),

              const SizedBox(height: 16),

              _buildBulletPoint(
                '- Нетерпелив к медленным людям',
                1200,
              ),
              _buildBulletPoint(
                '- Можешь задавить других своей энергией',
                1300,
              ),
              _buildBulletPoint(
                '- Детали и рутина вызывают скуку',
                1400,
              ),

              const SizedBox(height: 40),

              // Разделитель
              Divider(
                color: Colors.white.withOpacity(0.1),
                thickness: 1,
              ),

              const SizedBox(height: 40),

              // Что дальше
              Text(
                '💡 ЧТО ДАЛЬШЕ?',
                style: AppTextStyles.h2.copyWith(fontSize: 18),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ).animate(delay: 1500.ms).fadeIn(duration: 400.ms),

              const SizedBox(height: 12),

              Text(
                'Сейчас попадешь в mCode — твою базу роста.',
                style: AppTextStyles.body.copyWith(
                  color: Colors.white70,
                  fontSize: 13,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ).animate(delay: 1600.ms).fadeIn(duration: 400.ms),

              const SizedBox(height: 16),

              Text(
                'Там тебя ждет:',
                style: AppTextStyles.body.copyWith(
                  color: Colors.white70,
                  fontSize: 13,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ).animate(delay: 1700.ms).fadeIn(duration: 400.ms),

              const SizedBox(height: 12),

              _buildBulletPoint(
                '🎯 Персональный план развития',
                1800,
              ),
              _buildBulletPoint(
                '🎮 Живые тренировки с людьми (с 5 уровня)',
                1900,
              ),
              _buildBulletPoint(
                '🏆 Система прогресса и наград',
                2000,
              ),

              const SizedBox(height: 20),

              Text(
                'Ты готов начать путь в Mycelium?',
                style: AppTextStyles.h3.copyWith(fontSize: 15),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ).animate(delay: 2100.ms).fadeIn(duration: 400.ms),

              const SizedBox(height: 20),

              // Кнопка
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const MainNavigator(),
                      ),
                    );
                  },
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
                        'Войти в mCode',
                        style: AppTextStyles.h3.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward, size: 20),
                    ],
                  ),
                ),
              )
                  .animate(delay: 2200.ms)
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: 0.3, end: 0, duration: 600.ms),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text, int delayMs) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: AppTextStyles.body.copyWith(
          color: Colors.white70,
          fontSize: 13,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ).animate(delay: delayMs.ms).fadeIn(duration: 400.ms).slideX(
            begin: -0.2,
            end: 0,
            duration: 400.ms,
          ),
    );
  }
}
