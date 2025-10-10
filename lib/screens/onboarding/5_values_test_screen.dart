import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '../../models/test_result.dart';
import '6_results_screen.dart';

class ValuesTestScreen extends StatefulWidget {
  final List<String> selectedPains;
  final Map<String, int> discScores;
  final Map<String, int> bigFiveScores;

  const ValuesTestScreen({
    super.key,
    required this.selectedPains,
    required this.discScores,
    required this.bigFiveScores,
  });

  @override
  State<ValuesTestScreen> createState() => _ValuesTestScreenState();
}

class _ValuesTestScreenState extends State<ValuesTestScreen> {
  final List<String> _selectedProblems = [];

  // 8 сфер для выбора приоритетов (согласно ТЗ v3.3)
  final List<SphereItem> _spheres = [
    SphereItem('ДЕНЬГИ', '💰', 'Финансы, доходы, инвестиции'),
    SphereItem('ОТНОШЕНИЯ', '💕', 'Семья, друзья, партнер'),
    SphereItem('ЦЕЛИ', '🎯', 'Карьера, амбиции, достижения'),
    SphereItem('ЗДОРОВЬЕ', '🏥', 'Физическое состояние, энергия'),
    SphereItem('ПСИХОЛОГИЯ', '🧠', 'Ментальное здоровье, эмоции'),
    SphereItem('РАЗВИТИЕ', '📈', 'Обучение, рост, новые навыки'),
    SphereItem('ТВОРЧЕСТВО', '🎨', 'Креатив, хобби, самовыражение'),
    SphereItem('СМЫСЛ', '🔮', 'Духовность, ценности, цель жизни'),
  ];

  void _toggleProblem(String problem) {
    setState(() {
      if (_selectedProblems.contains(problem)) {
        _selectedProblems.remove(problem);
      } else {
        if (_selectedProblems.length < 3) {
          _selectedProblems.add(problem);
        }
      }
    });
  }

  void _complete() {
    if (_selectedProblems.length != 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _selectedProblems.length < 3
                ? 'Выбери еще ${3 - _selectedProblems.length}'
                : 'Выбери только 3',
          ),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // Переходим к Results screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const ResultsScreen(),
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
              padding: const EdgeInsets.all(16.0),
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

                  const SizedBox(height: 16),

                  // Заголовок
                  Text(
                    '🎯 Что хочешь прокачать в первую очередь?',
                    style: AppTextStyles.h1.copyWith(fontSize: 22),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ).animate()
                    .fadeIn(duration: 400.ms)
                    .slideX(begin: -0.2, end: 0, duration: 400.ms),

                  const SizedBox(height: 8),

                  Text(
                    'Выбери 3 сферы для старта',
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white60,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ).animate()
                    .fadeIn(delay: 200.ms, duration: 400.ms)
                    .slideX(begin: -0.2, end: 0, delay: 200.ms, duration: 400.ms),

                  const SizedBox(height: 12),

                  // Индикатор выбранных
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: index < _selectedProblems.length ? 40 : 32,
                          height: 8,
                          decoration: BoxDecoration(
                            color: index < _selectedProblems.length
                                ? AppColors.primaryPurple
                                : Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Сферы жизни
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: _spheres.length,
                  itemBuilder: (context, index) {
                    final sphere = _spheres[index];
                    final isSelected = _selectedProblems.contains(sphere.problem);

                    return _SphereCard(
                      sphere: sphere,
                      isSelected: isSelected,
                      onTap: () => _toggleProblem(sphere.problem),
                    ).animate()
                      .fadeIn(delay: (index * 50).ms, duration: 400.ms)
                      .scale(delay: (index * 50).ms, duration: 400.ms);
                  },
                ),
              ),
            ),

            // Кнопка завершения
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                        'Продолжить',
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
}

class SphereItem {
  final String name;
  final String emoji;
  final String problem;

  SphereItem(this.name, this.emoji, this.problem);
}

class _SphereCard extends StatelessWidget {
  final SphereItem sphere;
  final bool isSelected;
  final VoidCallback onTap;

  const _SphereCard({
    required this.sphere,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              sphere.emoji,
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 6),
            Text(
              sphere.name,
              style: AppTextStyles.body.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              sphere.problem,
              style: AppTextStyles.caption.copyWith(
                color: Colors.white60,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
