import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../models/p2p_scenario.dart';

class P2PScreen extends StatefulWidget {
  const P2PScreen({super.key});

  @override
  State<P2PScreen> createState() => _P2PScreenState();
}

class _P2PScreenState extends State<P2PScreen> {
  bool showAllScenarios = false;
  bool showProList = false;
  final List<P2PScenario> _likedScenarios = [];
  int _currentIndex = 0;
  List<P2PScenario> _scenarios = [];

  @override
  void initState() {
    super.initState();
    _scenarios = P2PScenario.getTopScenarios();
  }

  void _handleNo() {
    if (_currentIndex >= _scenarios.length) return;

    final scenario = _scenarios[_currentIndex];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('👋 ${scenario.title} пропущен'),
        backgroundColor: AppColors.textSecondary,
        duration: const Duration(seconds: 1),
      ),
    );

    setState(() {
      _currentIndex++;
    });
  }

  void _handleYes() {
    if (_currentIndex >= _scenarios.length) return;

    final scenario = _scenarios[_currentIndex];
    setState(() {
      _likedScenarios.add(scenario);
      _currentIndex++;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('❤️ ${scenario.title} добавлен'),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.background, Color(0xFF1A1F3A)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showProList = !showProList;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: AppDecorations.glassCard,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.success,
                                shape: BoxShape.circle,
                              ),
                            )
                                .animate(
                                  onPlay: (controller) => controller.repeat(),
                                )
                                .fadeIn(duration: 1000.ms)
                                .fadeOut(duration: 1000.ms),
                            const SizedBox(width: 10),
                            const Text(
                              '247 человек онлайн',
                              style: AppTextStyles.caption,
                            ),
                            const SizedBox(width: 6),
                            Icon(
                              showProList ? Icons.expand_less : Icons.expand_more,
                              size: 18,
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(),

                    const SizedBox(height: 24),

                    Text(
                      'P2P Рулетка',
                      style: AppTextStyles.h1,
                    ).animate(delay: 100.ms).fadeIn(),

                    const SizedBox(height: 8),

                    Text(
                      'Выбери интересные сценарии',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ).animate(delay: 150.ms).fadeIn(),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: _currentIndex >= _scenarios.length
                    ? _buildCompleteView()
                    : _buildScenarioView(_scenarios[_currentIndex]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScenarioView(P2PScenario scenario) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Progress indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${_currentIndex + 1} / ${_scenarios.length}',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.primaryPurple,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Scenario Card
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.cardBackground,
                    AppColors.cardBackground.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Category badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryPurple.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.primaryPurple.withOpacity(0.4),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      _getCategoryName(scenario.category),
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primaryPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Emoji
                  Text(
                    scenario.emoji,
                    style: const TextStyle(fontSize: 80),
                  ),

                  const SizedBox(height: 24),

                  // Title
                  Text(
                    scenario.title,
                    style: AppTextStyles.h1.copyWith(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  // Description
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        scenario.description,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Yes/No Buttons
          Row(
            children: [
              // No Button
              Expanded(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.red.withOpacity(0.5),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: _handleNo,
                      child: Center(
                        child: Text(
                          'НЕТ',
                          style: AppTextStyles.h2.copyWith(
                            color: Colors.red,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Yes Button
              Expanded(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: AppGradients.successGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.success.withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: _handleYes,
                      child: Center(
                        child: Text(
                          'ДА',
                          style: AppTextStyles.h2.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Liked scenarios count
          if (_likedScenarios.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.success.withOpacity(0.4),
                  width: 1,
                ),
              ),
              child: Text(
                '❤️ Выбрано: ${_likedScenarios.length}',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ).animate().fadeIn().scale(),
        ],
      ),
    );
  }

  Widget _buildCompleteView() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '🎉',
            style: TextStyle(fontSize: 80),
          ),
          const SizedBox(height: 20),
          const Text(
            'Все сценарии просмотрены!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            _likedScenarios.isEmpty
                ? 'Не выбрано ни одного сценария'
                : 'Выбрано сценариев: ${_likedScenarios.length}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),

          if (_likedScenarios.isNotEmpty) ...[
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                gradient: AppGradients.primaryGradient,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryPurple.withOpacity(0.4),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Ищем партнера для ${_likedScenarios.length} сценариев',
                        ),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.casino,
                          size: 48,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Начать сессию',
                          style: AppTextStyles.h1.copyWith(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ).animate(delay: 300.ms).fadeIn().scale(begin: const Offset(0.9, 0.9)),
          ],

          const SizedBox(height: 24),

          TextButton(
            onPressed: () {
              setState(() {
                _currentIndex = 0;
                _likedScenarios.clear();
              });
            },
            child: Text(
              'Начать заново',
              style: AppTextStyles.body.copyWith(
                color: AppColors.primaryPurple,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getCategoryName(String category) {
    switch (category) {
      case 'career':
        return 'Карьера';
      case 'relationships':
        return 'Отношения';
      case 'conflict':
        return 'Конфликт';
      case 'emotional':
        return 'Эмоции';
      case 'social':
        return 'Социум';
      case 'cognitive':
        return 'Мышление';
      default:
        return category;
    }
  }
}
