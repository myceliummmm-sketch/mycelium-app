import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '3_disc_test_screen.dart';

class PainPointsScreen extends StatefulWidget {
  const PainPointsScreen({super.key});

  @override
  State<PainPointsScreen> createState() => _PainPointsScreenState();
}

class _PainPointsScreenState extends State<PainPointsScreen> {
  final List<String> _selectedPains = [];

  // Список всех болевых точек
  final List<PainPoint> _painPoints = [
    PainPoint('Не хватает денег', '💸'),
    PainPoint('Нет времени', '⏰'),
    PainPoint('Проблемы в отношениях', '💔'),
    PainPoint('Не знаю чего хочу', '🤷'),
    PainPoint('Нет энергии', '😴'),
    PainPoint('Стресс и тревога', '😰'),
    PainPoint('Застрял на месте', '🚧'),
    PainPoint('Нет мотивации', '😶'),
    PainPoint('Одиночество', '😔'),
    PainPoint('Страх перемен', '😨'),
  ];

  void _togglePain(String pain) {
    setState(() {
      if (_selectedPains.contains(pain)) {
        _selectedPains.remove(pain);
      } else {
        // Максимум 3
        if (_selectedPains.length < 3) {
          _selectedPains.add(pain);
        }
      }
    });
  }

  void _continue() {
    if (_selectedPains.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Выбери хотя бы одну болевую точку'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DiscTestScreen(selectedPains: _selectedPains),
      ),
    );
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
            // Хедер с прогрессом
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
                          value: 1 / 6, // Шаг 1 из 6
                          backgroundColor: Colors.white.withOpacity(0.1),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryPurple,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '1/6',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Заголовок
                  Text(
                    'Что тебя беспокоит?',
                    style: AppTextStyles.h1,
                  ).animate()
                    .fadeIn(duration: 400.ms)
                    .slideX(begin: -0.2, end: 0, duration: 400.ms),

                  const SizedBox(height: 12),

                  Text(
                    'Выбери от 1 до 3 болевых точек',
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white60,
                    ),
                  ).animate()
                    .fadeIn(delay: 200.ms, duration: 400.ms)
                    .slideX(begin: -0.2, end: 0, delay: 200.ms, duration: 400.ms),
                ],
              ),
            ),

            // Список болевых точек
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: _painPoints.length,
                itemBuilder: (context, index) {
                  final pain = _painPoints[index];
                  final isSelected = _selectedPains.contains(pain.text);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _PainCard(
                      pain: pain,
                      isSelected: isSelected,
                      onTap: () => _togglePain(pain.text),
                    ).animate()
                      .fadeIn(delay: (300 + index * 50).ms, duration: 400.ms)
                      .slideX(
                        begin: -0.2,
                        end: 0,
                        delay: (300 + index * 50).ms,
                        duration: 400.ms,
                      ),
                  );
                },
              ),
            ),

            // Кнопка продолжить
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Счетчик выбранных
                  if (_selectedPains.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        'Выбрано: ${_selectedPains.length}/3',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.primaryPurple,
                        ),
                      ).animate()
                        .fadeIn(duration: 200.ms)
                        .scale(duration: 200.ms),
                    ),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _continue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedPains.isEmpty
                            ? Colors.white.withOpacity(0.1)
                            : AppColors.primaryPurple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Продолжить',
                        style: AppTextStyles.h3.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PainPoint {
  final String text;
  final String emoji;

  PainPoint(this.text, this.emoji);
}

class _PainCard extends StatelessWidget {
  final PainPoint pain;
  final bool isSelected;
  final VoidCallback onTap;

  const _PainCard({
    required this.pain,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryPurple.withOpacity(0.2)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryPurple
                : Colors.white.withOpacity(0.1),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            // Emoji
            Text(
              pain.emoji,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(width: 16),

            // Текст
            Expanded(
              child: Text(
                pain.text,
                style: AppTextStyles.body.copyWith(
                  color: Colors.white,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),

            // Чекбокс
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryPurple : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primaryPurple : Colors.white.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
