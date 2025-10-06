import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../models/sphere.dart';
import '../models/metaskill.dart';
import '../models/test_model.dart';

class TestsScreen extends StatefulWidget {
  const TestsScreen({super.key});

  @override
  State<TestsScreen> createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  Sphere? _selectedSphere;

  final List<TestModel> _allTests = [
    TestModel(
      id: 'mbti',
      title: 'MBTI',
      emoji: '🧠',
      description: 'Типология личности',
      duration: 15,
      reward: 50,
      progress: 0.4,
      spheres: [Sphere.career, Sphere.relationships, Sphere.growth],
      metaskills: [
        Metaskill.selfAwareness,
        Metaskill.communication,
        Metaskill.criticalThinking
      ],
      gradient: AppGradients.purpleGradient,
    ),
    TestModel(
      id: 'bigfive',
      title: 'Big Five',
      emoji: '⭐',
      description: 'Большая пятерка',
      duration: 20,
      reward: 75,
      isCompleted: true,
      spheres: [Sphere.career, Sphere.growth, Sphere.learning],
      metaskills: [
        Metaskill.selfAwareness,
        Metaskill.emotionalRegulation,
        Metaskill.adaptability
      ],
      gradient: AppGradients.blueGradient,
    ),
    TestModel(
      id: 'enneagram',
      title: 'Эннеаграмма',
      emoji: '🔢',
      description: 'Система из 9 типов',
      duration: 25,
      reward: 100,
      isLocked: true,
      spheres: [Sphere.growth, Sphere.relationships, Sphere.goals],
      metaskills: [
        Metaskill.selfAwareness,
        Metaskill.empathy,
        Metaskill.emotionalRegulation
      ],
      gradient: AppGradients.primaryGradient,
    ),
    TestModel(
      id: 'empathy',
      title: 'Эмпатия',
      emoji: '❤️',
      description: 'Уровень сопереживания',
      duration: 10,
      reward: 40,
      isNew: true,
      spheres: [Sphere.relationships, Sphere.health],
      metaskills: [Metaskill.empathy, Metaskill.communication, Metaskill.emotionalRegulation],
      gradient: AppGradients.warningGradient,
    ),
    TestModel(
      id: 'creativity',
      title: 'Креативность',
      emoji: '🎨',
      description: 'Творческий потенциал',
      duration: 15,
      reward: 60,
      isNew: true,
      spheres: [Sphere.creativity, Sphere.career, Sphere.learning],
      metaskills: [Metaskill.creativity, Metaskill.systemsThinking, Metaskill.adaptability],
      gradient: AppGradients.yellowGradient,
    ),
    TestModel(
      id: 'leadership',
      title: 'Лидерство',
      emoji: '👑',
      description: 'Лидерские качества',
      duration: 20,
      reward: 80,
      spheres: [Sphere.career, Sphere.goals],
      metaskills: [Metaskill.leadership, Metaskill.decisionMaking, Metaskill.communication],
      gradient: AppGradients.successGradient,
    ),
    TestModel(
      id: 'stress',
      title: 'Стрессоустойчивость',
      emoji: '🧘',
      description: 'Управление стрессом',
      duration: 12,
      reward: 45,
      spheres: [Sphere.health, Sphere.career, Sphere.goals],
      metaskills: [Metaskill.resilience, Metaskill.emotionalRegulation, Metaskill.adaptability],
      gradient: AppGradients.blueGradient,
    ),
    TestModel(
      id: 'finance',
      title: 'Финансовая грамотность',
      emoji: '💰',
      description: 'Отношение к деньгам',
      duration: 18,
      reward: 70,
      spheres: [Sphere.finance, Sphere.goals, Sphere.growth],
      metaskills: [Metaskill.planning, Metaskill.decisionMaking, Metaskill.execution],
      gradient: AppGradients.yellowGradient,
    ),
  ];

  List<TestModel> get _filteredTests {
    if (_selectedSphere == null) {
      return _allTests;
    }
    return _allTests
        .where((test) => test.spheres.contains(_selectedSphere))
        .toList();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Тесты личности',
                      style: AppTextStyles.h1,
                    ).animate().fadeIn().slideX(begin: -0.2, end: 0),
                    const SizedBox(height: 8),
                    const Text(
                      'Узнайте больше о себе',
                      style: AppTextStyles.bodySecondary,
                    ).animate().fadeIn(delay: 100.ms),
                  ],
                ),
              ),

              // Sphere filters
              SizedBox(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildSphereChip(
                      label: 'Все',
                      emoji: '✨',
                      isSelected: _selectedSphere == null,
                      onTap: () {
                        setState(() {
                          _selectedSphere = null;
                        });
                      },
                    ),
                    ...Sphere.values.map((sphere) {
                      return _buildSphereChip(
                        label: sphere.title,
                        emoji: sphere.emoji,
                        isSelected: _selectedSphere == sphere,
                        onTap: () {
                          setState(() {
                            _selectedSphere = sphere;
                          });
                        },
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Tests list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _filteredTests.length,
                  itemBuilder: (context, index) {
                    return _buildTestCard(
                      context,
                      test: _filteredTests[index],
                      delay: index * 100,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSphereChip({
    required String label,
    required String emoji,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 6),
            Text(label),
          ],
        ),
        selected: isSelected,
        onSelected: (_) => onTap(),
        backgroundColor: AppColors.cardBackground,
        selectedColor: AppColors.primaryPurple,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
        ),
        side: BorderSide(
          color: isSelected
              ? AppColors.primaryPurple
              : AppColors.textSecondary.withOpacity(0.3),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ).animate().fadeIn().scale(),
    );
  }

  Widget _buildTestCard(
    BuildContext context, {
    required TestModel test,
    required int delay,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: AppDecorations.cardBackground,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: test.isLocked
              ? null
              : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Открыть тест: ${test.title}')),
                  );
                },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: test.gradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          test.emoji,
                          style: const TextStyle(fontSize: 32),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                test.title,
                                style: AppTextStyles.h3,
                              ),
                              if (test.isNew) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.warning,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'NEW',
                                    style: AppTextStyles.badge,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            test.description,
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      test.isLocked ? Icons.lock : Icons.arrow_forward_ios,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Sphere badges
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: test.spheres.map((sphere) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryPurple.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: AppColors.primaryPurple.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        '${sphere.emoji} ${sphere.title}',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primaryPurple.withOpacity(0.9),
                          fontSize: 11,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 12),

                // Stats row
                Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${test.duration} мин',
                      style: AppTextStyles.caption,
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.token,
                      size: 14,
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+${test.reward} MYC',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.warning,
                      ),
                    ),
                  ],
                ),

                if (test.progress > 0 && !test.isCompleted) ...[
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: test.progress,
                      minHeight: 6,
                      backgroundColor: AppColors.textSecondary.withOpacity(0.2),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.success,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Прогресс: ${(test.progress * 100).toInt()}%',
                    style: AppTextStyles.caption.copyWith(fontSize: 12),
                  ),
                ],

                if (test.isCompleted) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: AppColors.success,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Пройден',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ],

                if (test.isLocked) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.lock,
                        color: AppColors.textSecondary,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Доступно с уровня 10',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: delay))
        .slideX(begin: -0.2, end: 0);
  }
}
