import 'dart:math' as dart_math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../models/p2p_scenario.dart';
import '../widgets/scenario_stack.dart';

class P2PScreen extends StatefulWidget {
  const P2PScreen({super.key});

  @override
  State<P2PScreen> createState() => _P2PScreenState();
}

class _P2PScreenState extends State<P2PScreen> {
  P2PScenario? selectedScenario;
  bool showAllScenarios = false;
  bool showProList = false;
  final GlobalKey _stackKey = GlobalKey();
  final List<P2PScenario> _likedScenarios = [];

  @override
  Widget build(BuildContext context) {
    final scenarios = showAllScenarios
        ? P2PScenario.getAllScenarios()
        : P2PScenario.getTopScenarios();

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Header - online indicator with PRO dropdown
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

                // PRO members list (locked)
                if (showProList)
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.warning.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                gradient: AppGradients.warningGradient,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'PRO',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                'Топ участников онлайн',
                                style: AppTextStyles.body,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ..._buildProMembers(),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Text('🔒', style: TextStyle(fontSize: 20)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Получи PRO статус чтобы видеть кто онлайн',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.warning,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn().slideY(begin: -0.1, end: 0),

                const SizedBox(height: 30),

                // Title
                Text(
                  'P2P Рулетка',
                  style: AppTextStyles.h1,
                ).animate(delay: 100.ms).fadeIn(),

                const SizedBox(height: 8),

                Text(
                  'Свайпни вправо если нравится, влево - пропустить',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ).animate(delay: 150.ms).fadeIn(),

                const SizedBox(height: 30),

                // Swipeable card stack
                SizedBox(
                  height: 480,
                  child: ScenarioStack(
                    key: _stackKey,
                    scenarios: scenarios,
                    onLike: (scenario) {
                      setState(() {
                        _likedScenarios.add(scenario);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('❤️ ${scenario.title} добавлен'),
                          backgroundColor: AppColors.success,
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    onSkip: (scenario) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('👋 ${scenario.title} пропущен'),
                          backgroundColor: AppColors.textSecondary,
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ).animate(delay: 200.ms).fadeIn().scale(begin: const Offset(0.95, 0.95)),

                const SizedBox(height: 24),

                // Swipe buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Skip button
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.red.withOpacity(0.5),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () => (_stackKey.currentState as dynamic)?.swipeLeft(),
                        icon: const Icon(Icons.close, size: 32),
                        color: Colors.red,
                        iconSize: 32,
                        padding: const EdgeInsets.all(20),
                      ),
                    ),
                    const SizedBox(width: 40),
                    // Like button
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.success.withOpacity(0.5),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.success.withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () => (_stackKey.currentState as dynamic)?.swipeRight(),
                        icon: const Icon(Icons.favorite, size: 32),
                        color: AppColors.success,
                        iconSize: 32,
                        padding: const EdgeInsets.all(20),
                      ),
                    ),
                  ],
                ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.1, end: 0),

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
                      '❤️ Выбрано сценариев: ${_likedScenarios.length}',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ).animate().fadeIn().scale(),

                const SizedBox(height: 30),

                // Start button
                if (_likedScenarios.isNotEmpty)
                  Container(
                    width: double.infinity,
                    height: 180,
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
                          // TODO: Start matching
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Ищем партнера для практики ${_likedScenarios.length} сценариев',
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
                                size: 64,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Начать сессию',
                                style: AppTextStyles.h1.copyWith(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${_likedScenarios.length} ${_getScenarioWord(_likedScenarios.length)}',
                                style: AppTextStyles.body.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                      .animate(delay: 700.ms)
                      .fadeIn()
                      .scale(begin: const Offset(0.9, 0.9)),

                const SizedBox(height: 24),

                // Info card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: AppDecorations.cardBackground,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            '💡',
                            style: TextStyle(fontSize: 24),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Как это работает?',
                              style: AppTextStyles.h3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '1. Выбери реальную ситуацию, которую хочешь отработать\n'
                        '2. Мы найдем тебе партнера с таким же запросом\n'
                        '3. Практикуйтесь вместе в безопасной среде\n'
                        '4. Получите фидбэк от AI и друг друга',
                        style: AppTextStyles.body,
                      ),
                    ],
                  ),
                ).animate(delay: 800.ms).fadeIn().slideY(begin: 0.2, end: 0),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildProMembers() {
    final mockProMembers = [
      {'name': 'Анна К.', 'level': 12, 'trust': 94, 'emoji': '💎'},
      {'name': 'Дмитрий С.', 'level': 15, 'trust': 98, 'emoji': '🔥'},
      {'name': 'Мария П.', 'level': 10, 'trust': 87, 'emoji': '✨'},
      {'name': 'Алексей В.', 'level': 18, 'trust': 99, 'emoji': '⭐'},
    ];

    return mockProMembers.map((member) {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppGradients.primaryGradient,
              ),
              child: Center(
                child: Text(
                  member['emoji'] as String,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member['name'] as String,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Lvl ${member['level']}',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.warning,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '🛡 ${member['trust']}',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  String _getScenarioWord(int count) {
    if (count % 10 == 1 && count % 100 != 11) {
      return 'сценарий';
    } else if (count % 10 >= 2 && count % 10 <= 4 && (count % 100 < 10 || count % 100 >= 20)) {
      return 'сценария';
    } else {
      return 'сценариев';
    }
  }
}
