import 'dart:math' as dart_math;
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
  P2PScenario? selectedScenario;
  bool showAllScenarios = false;
  bool showProList = false;

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
                  'Выбери сценарий для практики',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ).animate(delay: 150.ms).fadeIn(),

                const SizedBox(height: 30),

                // Scenario cubes (tags)
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: scenarios.map((scenario) {
                    final isSelected = selectedScenario?.id == scenario.id;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedScenario = isSelected ? null : scenario;
                        });
                      },
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: AppColors.cardBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: Row(
                              children: [
                                Text(scenario.emoji, style: const TextStyle(fontSize: 28)),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    scenario.title,
                                    style: AppTextStyles.h3,
                                  ),
                                ),
                              ],
                            ),
                            content: Text(
                              scenario.description,
                              style: AppTextStyles.body.copyWith(height: 1.6),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'Понятно',
                                  style: TextStyle(color: AppColors.primaryPurple),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? AppGradients.primaryGradient
                              : null,
                          color: isSelected
                              ? null
                              : AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryPurple
                                : Colors.white.withOpacity(0.1),
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColors.primaryPurple.withOpacity(0.4),
                                    blurRadius: 12,
                                    spreadRadius: 2,
                                  ),
                                ]
                              : null,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              scenario.emoji,
                              style: TextStyle(
                                fontSize: isSelected ? 22 : 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              scenario.title,
                              style: AppTextStyles.body.copyWith(
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                                fontSize: isSelected ? 15 : 14,
                              ),
                            ),
                          ],
                        ),
                      ).animate(delay: (200 + scenarios.indexOf(scenario) * 50).ms)
                          .fadeIn()
                          .scale(begin: const Offset(0.8, 0.8)),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),

                // Show more/less button
                if (!showAllScenarios)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showAllScenarios = true;
                      });
                    },
                    child: Text(
                      '+Показать ещё ${P2PScenario.getAllScenarios().length - P2PScenario.getTopScenarios().length} сценариев',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.primaryPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ).animate(delay: 600.ms).fadeIn()
                else
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showAllScenarios = false;
                      });
                    },
                    child: Text(
                      'Скрыть дополнительные сценарии',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.primaryPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ).animate().fadeIn(),

                const SizedBox(height: 30),

                // Start button
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: selectedScenario != null
                        ? AppGradients.primaryGradient
                        : LinearGradient(
                            colors: [
                              AppColors.textSecondary.withOpacity(0.3),
                              AppColors.textSecondary.withOpacity(0.2),
                            ],
                          ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: selectedScenario != null
                        ? [
                            BoxShadow(
                              color: AppColors.primaryPurple.withOpacity(0.4),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ]
                        : null,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: selectedScenario != null
                          ? () {
                              // TODO: Start matching
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Ищем партнера для: ${selectedScenario!.title}',
                                  ),
                                  backgroundColor: AppColors.success,
                                ),
                              );
                            }
                          : null,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.casino,
                              size: 64,
                              color: selectedScenario != null
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.3),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              selectedScenario != null
                                  ? 'Начать: ${selectedScenario!.emoji}'
                                  : 'Выбери сценарий',
                              style: AppTextStyles.h1.copyWith(
                                fontSize: 28,
                                color: selectedScenario != null
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.4),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            if (selectedScenario != null) ...[
                              const SizedBox(height: 8),
                              Text(
                                selectedScenario!.title,
                                style: AppTextStyles.body.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
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
}
