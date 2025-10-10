import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '5_values_test_screen.dart';

class BigFiveTestScreen extends StatefulWidget {
  final List<String> selectedPains;
  final Map<String, int> discScores;

  const BigFiveTestScreen({
    super.key,
    required this.selectedPains,
    required this.discScores,
  });

  @override
  State<BigFiveTestScreen> createState() => _BigFiveTestScreenState();
}

class _BigFiveTestScreenState extends State<BigFiveTestScreen> {
  int _currentQuestion = 0;
  final Map<String, int> _scores = {
    'O': 0, // Openness
    'C': 0, // Conscientiousness
    'E': 0, // Extraversion
    'A': 0, // Agreeableness
    'N': 0, // Neuroticism
  };
  bool _isTransitioning = false;
  int? _selectedAnswerIndex;

  final List<BigFiveQuestion> _questions = [
    BigFiveQuestion(
      'Ты открыт новому опыту?',
      [
        BigFiveAnswer('Да, люблю эксперименты', 'O', 2),
        BigFiveAnswer('Скорее да', 'O', 1),
        BigFiveAnswer('Предпочитаю знакомое', null, 0),
      ],
    ),
    BigFiveQuestion(
      'Ты организованный человек?',
      [
        BigFiveAnswer('Очень организованный', 'C', 2),
        BigFiveAnswer('В целом да', 'C', 1),
        BigFiveAnswer('Спонтанный', null, 0),
      ],
    ),
    BigFiveQuestion(
      'Ты экстраверт?',
      [
        BigFiveAnswer('Да, энергия от людей', 'E', 2),
        BigFiveAnswer('Зависит от настроения', 'E', 1),
        BigFiveAnswer('Нет, интроверт', null, 0),
      ],
    ),
    BigFiveQuestion(
      'Насколько ты доброжелательный?',
      [
        BigFiveAnswer('Очень, помогаю всем', 'A', 2),
        BigFiveAnswer('Стараюсь быть', 'A', 1),
        BigFiveAnswer('Реалист, не идеалист', null, 0),
      ],
    ),
    BigFiveQuestion(
      'Ты часто тревожишься?',
      [
        BigFiveAnswer('Редко беспокоюсь', null, 0),
        BigFiveAnswer('Иногда', 'N', 1),
        BigFiveAnswer('Да, часто волнуюсь', 'N', 2),
      ],
    ),
    BigFiveQuestion(
      'Как ты относишься к искусству?',
      [
        BigFiveAnswer('Обожаю, вдохновляет', 'O', 2),
        BigFiveAnswer('Нравится, но не фанат', 'O', 1),
        BigFiveAnswer('Равнодушен', null, 0),
      ],
    ),
    BigFiveQuestion(
      'Ты пунктуальный?',
      [
        BigFiveAnswer('Всегда вовремя', 'C', 2),
        BigFiveAnswer('Стараюсь', 'C', 1),
        BigFiveAnswer('Часто опаздываю', null, 0),
      ],
    ),
    BigFiveQuestion(
      'Тебе легко заводить друзей?',
      [
        BigFiveAnswer('Да, легко и быстро', 'E', 2),
        BigFiveAnswer('Могу, но не сразу', 'E', 1),
        BigFiveAnswer('Сложно, предпочитаю одиночество', null, 0),
      ],
    ),
    BigFiveQuestion(
      'Ты доверяешь людям?',
      [
        BigFiveAnswer('Да, верю в хорошее', 'A', 2),
        BigFiveAnswer('Нужно заслужить', 'A', 1),
        BigFiveAnswer('Скептически настроен', null, 0),
      ],
    ),
    BigFiveQuestion(
      'Ты эмоционально стабильный?',
      [
        BigFiveAnswer('Да, спокойный', null, 0),
        BigFiveAnswer('Бывают перепады', 'N', 1),
        BigFiveAnswer('Очень эмоциональный', 'N', 2),
      ],
    ),
  ];

  void _selectAnswer(int answerIndex, BigFiveAnswer answer) async {
    if (_isTransitioning) return;

    setState(() {
      _isTransitioning = true;
      _selectedAnswerIndex = answerIndex;
      if (answer.type != null) {
        _scores[answer.type!] = _scores[answer.type]! + answer.points;
      }
    });

    // Показываем выбор пользователю
    await Future.delayed(const Duration(milliseconds: 600));

    if (_currentQuestion < _questions.length - 1) {
      setState(() {
        _currentQuestion++;
        _isTransitioning = false;
        _selectedAnswerIndex = null;
      });
    } else{
      // Тест завершен, переходим к Values
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ValuesTestScreen(
            selectedPains: widget.selectedPains,
            discScores: widget.discScores,
            bigFiveScores: _scores,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestion];

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
                          value: 3 / 6, // Шаг 3 из 6
                          backgroundColor: Colors.white.withOpacity(0.1),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryPurple,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '3/6',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Прогресс внутри теста
                  Text(
                    'Вопрос ${_currentQuestion + 1} из ${_questions.length}',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primaryPurple,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Заголовок
                  Text(
                    'Big Five тест',
                    style: AppTextStyles.h2,
                  ),
                ],
              ),
            ),

            // Вопрос и ответы
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Вопрос
                    Text(
                      question.text,
                      style: AppTextStyles.h3.copyWith(fontSize: 20),
                    ).animate(
                      key: ValueKey(_currentQuestion),
                    ).fadeIn(duration: 400.ms).slideX(
                      begin: 0.2,
                      end: 0,
                      duration: 400.ms,
                    ),

                    const SizedBox(height: 32),

                    // Ответы
                    Expanded(
                      child: ListView.builder(
                        itemCount: question.answers.length,
                        itemBuilder: (context, index) {
                          final answer = question.answers[index];
                          final isSelected = _selectedAnswerIndex == index;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _AnswerCard(
                              answer: answer,
                              onTap: () => _selectAnswer(index, answer),
                              disabled: _isTransitioning,
                              isSelected: isSelected,
                            ).animate(
                              key: ValueKey('${_currentQuestion}_$index'),
                            ).fadeIn(
                              delay: (index * 80).ms,
                              duration: 400.ms,
                            ).slideX(
                              begin: 0.2,
                              end: 0,
                              delay: (index * 80).ms,
                              duration: 400.ms,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Подсказка
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Выбери наиболее подходящий вариант',
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white60,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BigFiveQuestion {
  final String text;
  final List<BigFiveAnswer> answers;

  BigFiveQuestion(this.text, this.answers);
}

class BigFiveAnswer {
  final String text;
  final String? type; // O, C, E, A, N (null для нейтральных)
  final int points;

  BigFiveAnswer(this.text, this.type, this.points);
}

class _AnswerCard extends StatelessWidget {
  final BigFiveAnswer answer;
  final VoidCallback onTap;
  final bool disabled;
  final bool isSelected;

  const _AnswerCard({
    required this.answer,
    required this.onTap,
    required this.disabled,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (disabled || isSelected) ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: isSelected ? AppGradients.primaryGradient : null,
          color: isSelected ? null : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryPurple
                : Colors.white.withOpacity(0.1),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: AppColors.primaryPurple.withOpacity(0.4),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ] : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                answer.text,
                style: AppTextStyles.body.copyWith(
                  color: Colors.white,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
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
    );
  }
}
