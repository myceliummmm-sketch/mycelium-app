import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bottom_navigation.dart';

class CelebrationScreen extends StatefulWidget {
  const CelebrationScreen({super.key});

  @override
  State<CelebrationScreen> createState() => _CelebrationScreenState();
}

class _CelebrationScreenState extends State<CelebrationScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _showMYCModal() {
    showDialog(
      context: context,
      builder: (context) => _buildMYCModal(),
    );
  }

  void _showXPModal() {
    showDialog(
      context: context,
      builder: (context) => _buildXPModal(),
    );
  }

  void _showProfileModal() {
    showDialog(
      context: context,
      builder: (context) => _buildProfileModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Контент
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // Анимированный гриб
                  Text(
                    '🍄',
                    style: const TextStyle(fontSize: 100),
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

                  const SizedBox(height: 24),

                  // Заголовок
                  Text(
                    '🎉 ПОЗДРАВЛЯЕМ!',
                    style: AppTextStyles.h1.copyWith(fontSize: 32),
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: -0.3, end: 0, duration: 600.ms),

                  const SizedBox(height: 16),

                  Text(
                    'Ты завершил Уровень 1\nи открыл Уровень 2!',
                    style: AppTextStyles.h3,
                    textAlign: TextAlign.center,
                  )
                      .animate(delay: 400.ms)
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: 0.2, end: 0, duration: 600.ms),

                  const SizedBox(height: 40),

                  Divider(color: Colors.white.withOpacity(0.2)),

                  const SizedBox(height: 32),

                  // Награды
                  Text(
                    '🎁 ТВОИ НАГРАДЫ:',
                    style: AppTextStyles.h2.copyWith(fontSize: 22),
                  ).animate(delay: 800.ms).fadeIn(duration: 400.ms),

                  const SizedBox(height: 24),

                  // Карточка 1: MYC
                  _buildRewardCard(
                    emoji: '💎',
                    title: '+150 MYC',
                    subtitle: 'Внутренняя валюта Mycelium',
                    hint: 'Тап для подробностей',
                    onTap: _showMYCModal,
                    delay: 1000,
                  ),

                  const SizedBox(height: 16),

                  // Карточка 2: XP
                  _buildRewardCard(
                    emoji: '⚡',
                    title: '+100 XP',
                    subtitle: 'Опыт для прокачки уровня',
                    hint: 'Тап для подробностей',
                    onTap: _showXPModal,
                    delay: 1200,
                  ),

                  const SizedBox(height: 16),

                  // Карточка 3: Профиль
                  _buildRewardCard(
                    emoji: '📊',
                    title: 'Твой профиль готов!',
                    subtitle: '8 сфер баланса построены',
                    hint: 'Тап чтобы посмотреть',
                    onTap: _showProfileModal,
                    delay: 1400,
                  ),

                  const SizedBox(height: 40),

                  Divider(color: Colors.white.withOpacity(0.2)),

                  const SizedBox(height: 32),

                  // Что дальше
                  Text(
                    '💡 ЧТО ДАЛЬШЕ?',
                    style: AppTextStyles.h2.copyWith(fontSize: 20),
                  ).animate(delay: 1600.ms).fadeIn(duration: 400.ms),

                  const SizedBox(height: 12),

                  Text(
                    'Уровень 2 разблокирован!',
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white70,
                    ),
                  ).animate(delay: 1800.ms).fadeIn(duration: 400.ms),

                  const SizedBox(height: 8),

                  Text(
                    'Новая сфера "Отношения" ждёт тебя',
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white70,
                    ),
                  ).animate(delay: 1900.ms).fadeIn(duration: 400.ms),

                  const SizedBox(height: 32),

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
                            'Перейти к Уровню 2',
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
                      .animate(delay: 2000.ms)
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: 0.3, end: 0, duration: 600.ms),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // Конфетти
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                AppColors.primaryPurple,
                AppColors.accentBlue,
                AppColors.accent,
                AppColors.accentOrange,
                AppColors.success,
              ],
              numberOfParticles: 50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardCard({
    required String emoji,
    required String title,
    required String subtitle,
    required String hint,
    required VoidCallback onTap,
    required int delay,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
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
          children: [
            Text(emoji, style: const TextStyle(fontSize: 48)),
            const SizedBox(height: 12),
            Text(
              title,
              style: AppTextStyles.h2.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: AppTextStyles.body.copyWith(
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              hint,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.accent,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    )
        .animate(delay: delay.ms)
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.2, end: 0, duration: 600.ms)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
  }

  Widget _buildMYCModal() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primaryPurple.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '💎 ЧТО ТАКОЕ MYC?',
                style: AppTextStyles.h2.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 16),
              Text(
                'MYC (Mycelium Coin) — внутренняя\nвалюта платформы.',
                style: AppTextStyles.body.copyWith(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '🎯 КАК ПОЛУЧАТЬ:',
                style: AppTextStyles.h3,
              ),
              const SizedBox(height: 12),
              _buildBulletPoint('+50 MYC - Завершил тест'),
              _buildBulletPoint('+100 MYC - Поставил цель'),
              _buildBulletPoint('+200 MYC - Достиг цели'),
              _buildBulletPoint('+150 MYC - Завершил уровень'),
              _buildBulletPoint('+500 MYC - Пригласил друга'),
              const SizedBox(height: 24),
              Text(
                '💸 НА ЧТО ТРАТИТЬ:',
                style: AppTextStyles.h3,
              ),
              const SizedBox(height: 12),
              _buildBulletPoint('150 MYC - AI-анализ детальный'),
              _buildBulletPoint('200 MYC - Приоритетный матчинг'),
              _buildBulletPoint('500 MYC - Мастер-класс эксперта'),
              const SizedBox(height: 24),
              Text(
                '💡 Чем больше активности,\nтем больше MYC!',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Понятно!'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildXPModal() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primaryPurple.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '⚡ ЧТО ТАКОЕ XP?',
                style: AppTextStyles.h2.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 16),
              Text(
                'XP (Experience Points) — опыт\nдля прокачки уровней.',
                style: AppTextStyles.body.copyWith(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '🎯 КАК ПОЛУЧАТЬ:',
                style: AppTextStyles.h3,
              ),
              const SizedBox(height: 12),
              _buildBulletPoint('+10 XP - Прошел тест'),
              _buildBulletPoint('+20 XP - Поставил цель'),
              _buildBulletPoint('+50 XP - Изучил все навыки сферы'),
              _buildBulletPoint('+70 XP - Оценил 8 сфер'),
              _buildBulletPoint('+10 XP - Вернулся на след. день'),
              const SizedBox(height: 24),
              Text(
                '🎮 СИСТЕМА УРОВНЕЙ:',
                style: AppTextStyles.h3,
              ),
              const SizedBox(height: 12),
              _buildBulletPoint('Уровень 1 → 2: 100 XP'),
              _buildBulletPoint('Уровень 2 → 3: 150 XP'),
              _buildBulletPoint('Уровень 3 → 4: 200 XP'),
              _buildBulletPoint('...'),
              _buildBulletPoint('Уровень 4 → 5: 250 XP'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.accentOrange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '🎮 P2P открывается!',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.accentOrange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '💡 Чем выше уровень,\nтем больше возможностей!',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Понятно!'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileModal() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primaryPurple.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '📊 ТВОЙ ПРОФИЛЬ',
                style: AppTextStyles.h2.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 16),
              _buildProfileRow('🎭 Тип:', 'Стратег-Визионер'),
              const SizedBox(height: 8),
              _buildProfileRow('DISC:', 'D (Лидер)'),
              const SizedBox(height: 16),
              Text(
                'Big Five:',
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              _buildBulletPoint('• Открытость: High'),
              _buildBulletPoint('• Добросовестность: Medium'),
              _buildBulletPoint('• Экстраверсия: High'),
              _buildBulletPoint('• Доброжелательность: Low'),
              _buildBulletPoint('• Нейротизм: Low'),
              const SizedBox(height: 16),
              Text(
                'Приоритетные сферы:',
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '💰 Деньги • 💕 Отношения • 🎯 Цели',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 24),
              Divider(color: Colors.white.withOpacity(0.2)),
              const SizedBox(height: 24),
              Text(
                '📊 8 СФЕР БАЛАНСА',
                style: AppTextStyles.h3,
              ),
              const SizedBox(height: 16),
              // TODO: Добавить паутину/радар-чарт
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '[Паутина/радар-чарт]',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white60,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildBulletPoint('💰 Деньги: 4/10'),
              _buildBulletPoint('💕 Отношения: 8/10'),
              _buildBulletPoint('🎯 Цели: 3/10'),
              _buildBulletPoint('🏥 Здоровье: 6/10'),
              _buildBulletPoint('🧠 Психология: 5/10'),
              _buildBulletPoint('📈 Развитие: 7/10'),
              _buildBulletPoint('🎨 Творчество: 2/10'),
              _buildBulletPoint('🔮 Смысл: 6/10'),
              const SizedBox(height: 24),
              Text(
                '💡 Эти данные помогут\nперсонализировать твой путь!',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Круто!'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: AppTextStyles.body.copyWith(
          color: Colors.white70,
        ),
      ),
    );
  }

  Widget _buildProfileRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: AppTextStyles.body.copyWith(
            color: Colors.white60,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: AppTextStyles.body.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
