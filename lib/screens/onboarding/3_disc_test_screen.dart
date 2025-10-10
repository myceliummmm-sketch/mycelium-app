import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '4_big_five_test_screen.dart';

class DiscTestScreen extends StatefulWidget {
  final List<String> selectedPains;

  const DiscTestScreen({
    super.key,
    required this.selectedPains,
  });

  @override
  State<DiscTestScreen> createState() => _DiscTestScreenState();
}

class _DiscTestScreenState extends State<DiscTestScreen> {
  int _currentQuestion = 0;
  final Map<String, int> _scores = {'D': 0, 'I': 0, 'S': 0, 'C': 0};
  bool _isTransitioning = false;
  String? _selectedAnswerType;

  final List<DiscQuestion> _questions = [
    DiscQuestion(
      'Как ты принимаешь решения?',
      [
        DiscAnswer('Быстро и решительно', 'D'),
        DiscAnswer('Обсуждая с другими', 'I'),
        DiscAnswer('Взвешенно и осторожно', 'S'),
        DiscAnswer('Анализируя все данные', 'C'),
      ],
    ),
    DiscQuestion(
      'В конфликтной ситуации ты...',
      [
        DiscAnswer('Сразу решаешь проблему', 'D'),
        DiscAnswer('Пытаешься сгладить', 'I'),
        DiscAnswer('Избегаешь конфронтации', 'S'),
        DiscAnswer('Ищешь логичное решение', 'C'),
      ],
    ),
    DiscQuestion(
      'Твой подход к работе:',
      [
        DiscAnswer('Фокус на результате', 'D'),
        DiscAnswer('Командная работа', 'I'),
        DiscAnswer('Стабильность и порядок', 'S'),
        DiscAnswer('Качество и точность', 'C'),
      ],
    ),
    DiscQuestion(
      'Что тебя мотивирует?',
      [
        DiscAnswer('Вызовы и достижения', 'D'),
        DiscAnswer('Признание окружающих', 'I'),
        DiscAnswer('Безопасность и гармония', 'S'),
        DiscAnswer('Правильность и точность', 'C'),
      ],
    ),
    DiscQuestion(
      'Твой стиль общения:',
      [
        DiscAnswer('Прямой и краткий', 'D'),
        DiscAnswer('Живой и эмоциональный', 'I'),
        DiscAnswer('Спокойный и терпеливый', 'S'),
        DiscAnswer('Точный и детальный', 'C'),
      ],
    ),
    DiscQuestion(
      'В новой команде ты...',
      [
        DiscAnswer('Быстро берешь инициативу', 'D'),
        DiscAnswer('Знакомишься со всеми', 'I'),
        DiscAnswer('Наблюдаешь и адаптируешься', 'S'),
        DiscAnswer('Изучаешь процессы', 'C'),
      ],
    ),
    DiscQuestion(
      'Как ты относишься к переменам?',
      [
        DiscAnswer('Приветствую вызовы', 'D'),
        DiscAnswer('Вижу возможности', 'I'),
        DiscAnswer('Нужно время на адаптацию', 'S'),
        DiscAnswer('Нужен план и структура', 'C'),
      ],
    ),
    DiscQuestion(
      'Твой темп работы:',
      [
        DiscAnswer('Быстрый, интенсивный', 'D'),
        DiscAnswer('Энергичный, с перерывами', 'I'),
        DiscAnswer('Устойчивый, размеренный', 'S'),
        DiscAnswer('Методичный, тщательный', 'C'),
      ],
    ),
    DiscQuestion(
      'Что для тебя важнее?',
      [
        DiscAnswer('Власть и контроль', 'D'),
        DiscAnswer('Влияние и популярность', 'I'),
        DiscAnswer('Стабильность и лояльность', 'S'),
        DiscAnswer('Компетентность и точность', 'C'),
      ],
    ),
    DiscQuestion(
      'Твой стиль руководства:',
      [
        DiscAnswer('Директивный, решительный', 'D'),
        DiscAnswer('Вдохновляющий, мотивирующий', 'I'),
        DiscAnswer('Поддерживающий, терпеливый', 'S'),
        DiscAnswer('Системный, аналитический', 'C'),
      ],
    ),
    DiscQuestion(
      'Как ты справляешься со стрессом?',
      [
        DiscAnswer('Беру ситуацию под контроль', 'D'),
        DiscAnswer('Делюсь с друзьями', 'I'),
        DiscAnswer('Жду когда всё утихнет', 'S'),
        DiscAnswer('Анализирую причины', 'C'),
      ],
    ),
    DiscQuestion(
      'Твоя главная слабость:',
      [
        DiscAnswer('Нетерпеливость', 'D'),
        DiscAnswer('Недисциплинированность', 'I'),
        DiscAnswer('Избегание конфликтов', 'S'),
        DiscAnswer('Перфекционизм', 'C'),
      ],
    ),
  ];

  void _selectAnswer(DiscAnswer answer) async {
    if (_isTransitioning) return;

    setState(() {
      _isTransitioning = true;
      _selectedAnswerType = answer.type;
      _scores[answer.type] = _scores[answer.type]! + 1;
    });

    // Показываем выбор пользователю
    await Future.delayed(const Duration(milliseconds: 600));

    if (_currentQuestion < _questions.length - 1) {
      setState(() {
        _currentQuestion++;
        _isTransitioning = false;
        _selectedAnswerType = null;
      });
    } else {
      // Тест завершен, переходим к Big Five
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => BigFiveTestScreen(
            selectedPains: widget.selectedPains,
            discScores: _scores,
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
                          value: 2 / 6, // Шаг 2 из 6
                          backgroundColor: Colors.white.withOpacity(0.1),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryPurple,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '2/6',
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
                    'DISC тест',
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

                          final isSelected = _selectedAnswerType == answer.type;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _AnswerCard(
                              answer: answer,
                              onTap: () => _selectAnswer(answer),
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

class DiscQuestion {
  final String text;
  final List<DiscAnswer> answers;

  DiscQuestion(this.text, this.answers);
}

class DiscAnswer {
  final String text;
  final String type; // D, I, S, C

  DiscAnswer(this.text, this.type);
}

class _AnswerCard extends StatelessWidget {
  final DiscAnswer answer;
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
      onTap: disabled ? null : onTap,
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
