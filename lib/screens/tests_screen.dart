import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../models/sphere.dart';
import '../models/metaskill.dart';
import '../models/test_model.dart';
import 'onboarding_quiz_screen.dart';

class TestsScreen extends StatefulWidget {
  const TestsScreen({super.key});

  @override
  State<TestsScreen> createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  final List<TestModel> _allTests = [
    TestModel(
      id: 'mbti',
      title: 'MBTI',
      emoji: '🧠',
      description: '16 типов личности',
      duration: 15,
      reward: 50,
      progress: 0.6,
      spheres: [Sphere.career, Sphere.relationships, Sphere.growth],
      metaskills: [
        Metaskill.selfAwareness,
        Metaskill.communication,
        Metaskill.criticalThinking
      ],
      gradient: AppGradients.purpleGradient,
    ),
    TestModel(
      id: 'empathy',
      title: 'Эмпатия',
      emoji: '❤️',
      description: 'Уровень сопереживания',
      duration: 10,
      reward: 40,
      progress: 0.4,
      spheres: [Sphere.relationships, Sphere.health],
      metaskills: [Metaskill.empathy, Metaskill.communication, Metaskill.emotionalRegulation],
      gradient: AppGradients.warningGradient,
    ),
    TestModel(
      id: 'stress',
      title: 'Стрессоустойчивость',
      emoji: '🧘',
      description: 'Управление стрессом',
      duration: 12,
      reward: 45,
      progress: 0.45,
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
      progress: 0.4,
      spheres: [Sphere.finance, Sphere.goals, Sphere.growth],
      metaskills: [Metaskill.planning, Metaskill.decisionMaking, Metaskill.execution],
      gradient: AppGradients.yellowGradient,
    ),
  ];

  final List<TestModel> _availableTests = [
    TestModel(
      id: 'bigfive',
      title: 'Big Five',
      emoji: '⭐',
      description: 'Большая пятерка',
      duration: 20,
      reward: 75,
      spheres: [Sphere.career, Sphere.growth, Sphere.learning],
      metaskills: [
        Metaskill.selfAwareness,
        Metaskill.emotionalRegulation,
        Metaskill.adaptability
      ],
      gradient: AppGradients.blueGradient,
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
  ];

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Привет, Moss!',
                        style: AppTextStyles.h1,
                      ).animate().fadeIn().slideX(begin: -0.2, end: 0),
                    ],
                  ),
                ),

                // Big Play Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingQuizScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B6B),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 8,
                        shadowColor: const Color(0xFFFF6B6B).withOpacity(0.5),
                      ),
                      child: const Text(
                        'Играть',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ).animate(delay: 100.ms).fadeIn().scale(begin: const Offset(0.95, 0.95)),

                const SizedBox(height: 24),

                // What would you like to play today?
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Во что хотите поиграть сегодня?',
                    style: AppTextStyles.body,
                  ),
                ).animate(delay: 150.ms).fadeIn(),

                const SizedBox(height: 16),

                // Available tests carousel
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _availableTests.length,
                    itemBuilder: (context, index) {
                      final test = _availableTests[index];
                      return Container(
                        width: 160,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          gradient: test.gradient,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // TODO: Start test
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        test.emoji,
                                        style: const TextStyle(fontSize: 32),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        test.title,
                                        style: AppTextStyles.h3.copyWith(
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${test.duration} вопросов',
                                        style: AppTextStyles.caption.copyWith(
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ).animate(delay: Duration(milliseconds: 200 + index * 100)).fadeIn().slideX(begin: 0.2, end: 0);
                    },
                  ),
                ),

                const SizedBox(height: 32),

                // Unfinished Games
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Незавершенные игры',
                    style: AppTextStyles.h2,
                  ),
                ).animate(delay: 500.ms).fadeIn(),

                const SizedBox(height: 16),

                // Unfinished games list
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _allTests.length,
                  itemBuilder: (context, index) {
                    final test = _allTests[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            // TODO: Continue test
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    gradient: test.gradient,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      test.emoji,
                                      style: const TextStyle(fontSize: 28),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        test.title,
                                        style: AppTextStyles.body.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: LinearProgressIndicator(
                                          value: test.progress,
                                          minHeight: 6,
                                          backgroundColor: Colors.white.withOpacity(0.1),
                                          valueColor: const AlwaysStoppedAnimation<Color>(
                                            AppColors.primaryBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '${(test.progress * 100).toInt()}%',
                                  style: AppTextStyles.body.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ).animate(delay: Duration(milliseconds: 600 + index * 100)).fadeIn().slideY(begin: 0.1, end: 0);
                  },
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
