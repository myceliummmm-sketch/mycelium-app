import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../models/onboarding_question.dart';

class OnboardingQuizScreen extends StatefulWidget {
  const OnboardingQuizScreen({super.key});

  @override
  State<OnboardingQuizScreen> createState() => _OnboardingQuizScreenState();
}

class _OnboardingQuizScreenState extends State<OnboardingQuizScreen> {
  int currentQuestionIndex = 0;
  Map<String, String> answers = {}; // questionId -> optionId
  Map<String, int> discScores = {
    'D': 0,
    'I': 0,
    'S': 0,
    'C': 0,
  };
  List<String> selectedSkills = [];

  OnboardingQuestion get currentQuestion =>
      onboardingQuestions[currentQuestionIndex];

  bool get isLastQuestion =>
      currentQuestionIndex == onboardingQuestions.length - 1;

  double get progress => (currentQuestionIndex + 1) / onboardingQuestions.length;

  void _selectOption(OnboardingOption option) {
    setState(() {
      answers[currentQuestion.id] = option.id;

      // Update DISC scores
      discScores[option.discType] = (discScores[option.discType] ?? 0) + 1;

      // Add skills
      for (var skill in option.relatedSkills) {
        if (!selectedSkills.contains(skill)) {
          selectedSkills.add(skill);
        }
      }
    });

    // Auto-advance after selection
    Future.delayed(const Duration(milliseconds: 400), () {
      if (isLastQuestion) {
        _completeOnboarding();
      } else {
        _nextQuestion();
      }
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < onboardingQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void _completeOnboarding() {
    final result = OnboardingResult(
      discScores: discScores,
      preferredSkills: selectedSkills.take(3).toList(),
      communicationStyle: _getCommunicationStyle(),
    );

    // Navigate to results screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OnboardingResultScreen(result: result),
      ),
    );
  }

  String _getCommunicationStyle() {
    final dominantType = discScores.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;

    switch (dominantType) {
      case 'D':
        return 'direct';
      case 'I':
        return 'enthusiastic';
      case 'S':
        return 'supportive';
      case 'C':
        return 'analytical';
      default:
        return 'balanced';
    }
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
              // Header with progress
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (currentQuestionIndex > 0)
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: _previousQuestion,
                          )
                        else
                          const SizedBox(width: 48),
                        Text(
                          '${currentQuestionIndex + 1}/${onboardingQuestions.length}',
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        backgroundColor: Colors.white.withOpacity(0.1),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primaryPurple,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Question content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Emoji
                      Text(
                        currentQuestion.emoji,
                        style: const TextStyle(fontSize: 60),
                      )
                          .animate(key: ValueKey(currentQuestionIndex))
                          .scale(duration: 500.ms, curve: Curves.elasticOut),

                      const SizedBox(height: 20),

                      // Question
                      Text(
                        currentQuestion.question,
                        style: AppTextStyles.h1.copyWith(fontSize: 22),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      )
                          .animate(key: ValueKey('q_$currentQuestionIndex'))
                          .fadeIn(delay: 100.ms)
                          .slideY(begin: 0.2, end: 0),

                      const SizedBox(height: 24),

                      // Options
                      ...currentQuestion.options.asMap().entries.map((entry) {
                        final index = entry.key;
                        final option = entry.value;
                        final isSelected = answers[currentQuestion.id] == option.id;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? AppGradients.primaryGradient
                                : null,
                            color: isSelected
                                ? null
                                : AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(14),
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
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => _selectOption(option),
                              borderRadius: BorderRadius.circular(14),
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Row(
                                  children: [
                                    Text(
                                      option.emoji,
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        option.text,
                                        style: AppTextStyles.body.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (isSelected)
                                      const Icon(
                                        Icons.check_circle,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                            .animate(key: ValueKey('opt_$currentQuestionIndex\_$index'))
                            .fadeIn(delay: Duration(milliseconds: 200 + index * 100))
                            .slideX(begin: 0.2, end: 0);
                      }),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingResultScreen extends StatelessWidget {
  final OnboardingResult result;

  const OnboardingResultScreen({
    super.key,
    required this.result,
  });

  String _getDiscDescription(String discType) {
    switch (discType) {
      case 'D':
        return 'Ты прямолинейный и решительный лидер! Любишь брать инициативу и быстро достигать целей.';
      case 'I':
        return 'Ты харизматичный коммуникатор! Легко заводишь знакомства и вдохновляешь других.';
      case 'S':
        return 'Ты надежный и спокойный! Ценишь гармонию и умеешь поддерживать людей.';
      case 'C':
        return 'Ты аналитик и перфекционист! Любишь точность и принимаешь взвешенные решения.';
      default:
        return 'У тебя сбалансированный стиль! Ты умеешь адаптироваться к разным ситуациям.';
    }
  }

  String _getDiscEmoji(String discType) {
    switch (discType) {
      case 'D':
        return '🎯';
      case 'I':
        return '✨';
      case 'S':
        return '🤝';
      case 'C':
        return '📊';
      default:
        return '⚖️';
    }
  }

  String _getDiscTitle(String discType) {
    switch (discType) {
      case 'D':
        return 'Лидер-Доминатор';
      case 'I':
        return 'Вдохновитель';
      case 'S':
        return 'Поддерживатель';
      case 'C':
        return 'Аналитик';
      default:
        return 'Баланс';
    }
  }

  @override
  Widget build(BuildContext context) {
    final discType = result.dominantDiscType;

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
                const SizedBox(height: 40),

                // Success emoji
                const Text('🎉', style: TextStyle(fontSize: 100))
                    .animate()
                    .scale(duration: 800.ms, curve: Curves.elasticOut),

                const SizedBox(height: 32),

                Text(
                  'Готово!',
                  style: AppTextStyles.h1.copyWith(fontSize: 36),
                ).animate(delay: 200.ms).fadeIn(),

                const SizedBox(height: 16),

                Text(
                  'Мы определили твой стиль',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ).animate(delay: 300.ms).fadeIn(),

                const SizedBox(height: 40),

                // DISC Type Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: AppGradients.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryPurple.withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        _getDiscEmoji(discType),
                        style: const TextStyle(fontSize: 80),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _getDiscTitle(discType),
                        style: AppTextStyles.h1.copyWith(fontSize: 28),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _getDiscDescription(discType),
                        style: AppTextStyles.body.copyWith(height: 1.6),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ).animate(delay: 400.ms).fadeIn().scale(begin: const Offset(0.9, 0.9)),

                const SizedBox(height: 32),

                // Recommended Skills
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: AppDecorations.cardBackground,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Рекомендуем развивать:',
                        style: AppTextStyles.h3,
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: result.preferredSkills.map((skill) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              gradient: AppGradients.purpleGradient,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              skill,
                              style: AppTextStyles.body.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ).animate(delay: 500.ms).fadeIn().slideY(begin: 0.2, end: 0),

                const SizedBox(height: 32),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to main app
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryPurple,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Начать путешествие 🍄',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ).animate(delay: 600.ms).fadeIn().slideY(begin: 0.2, end: 0),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
