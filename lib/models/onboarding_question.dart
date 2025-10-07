class OnboardingQuestion {
  final String id;
  final String question;
  final String emoji;
  final List<OnboardingOption> options;
  final String category; // communication, goals, style, etc

  const OnboardingQuestion({
    required this.id,
    required this.question,
    required this.emoji,
    required this.options,
    required this.category,
  });
}

class OnboardingOption {
  final String id;
  final String text;
  final String emoji;
  final String discType; // D, I, S, C
  final List<String> relatedSkills;

  const OnboardingOption({
    required this.id,
    required this.text,
    required this.emoji,
    required this.discType,
    required this.relatedSkills,
  });
}

class OnboardingResult {
  final Map<String, int> discScores; // D, I, S, C scores
  final List<String> preferredSkills;
  final String communicationStyle;

  OnboardingResult({
    required this.discScores,
    required this.preferredSkills,
    required this.communicationStyle,
  });

  String get dominantDiscType {
    return discScores.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  Map<String, dynamic> toJson() {
    return {
      'discType': dominantDiscType,
      'discScores': discScores,
      'preferredSkills': preferredSkills,
      'communicationStyle': communicationStyle,
    };
  }
}

// Onboarding questions data
final List<OnboardingQuestion> onboardingQuestions = [
  OnboardingQuestion(
    id: 'communication_style',
    question: 'Как тебе комфортнее общаться с новыми людьми?',
    emoji: '💬',
    category: 'communication',
    options: [
      OnboardingOption(
        id: 'direct',
        text: 'Прямо к делу, без лишних слов',
        emoji: '🎯',
        discType: 'D', // Dominant
        relatedSkills: ['leadership', 'decision-making', 'execution'],
      ),
      OnboardingOption(
        id: 'enthusiastic',
        text: 'Весело и энергично, через истории',
        emoji: '✨',
        discType: 'I', // Influential
        relatedSkills: ['communication', 'creativity', 'empathy'],
      ),
      OnboardingOption(
        id: 'supportive',
        text: 'Спокойно и дружелюбно, слушая собеседника',
        emoji: '🤝',
        discType: 'S', // Steady
        relatedSkills: ['empathy', 'resilience', 'emotional-regulation'],
      ),
      OnboardingOption(
        id: 'analytical',
        text: 'Через факты и детальную информацию',
        emoji: '📊',
        discType: 'C', // Conscientious
        relatedSkills: ['critical-thinking', 'systems-thinking', 'planning'],
      ),
    ],
  ),
  OnboardingQuestion(
    id: 'negotiation_priority',
    question: 'Что для тебя важнее в переговорах?',
    emoji: '🤝',
    category: 'negotiation',
    options: [
      OnboardingOption(
        id: 'results',
        text: 'Быстрый результат и победа',
        emoji: '🏆',
        discType: 'D',
        relatedSkills: ['leadership', 'execution', 'decision-making'],
      ),
      OnboardingOption(
        id: 'relationship',
        text: 'Построить доверие и хорошие отношения',
        emoji: '❤️',
        discType: 'I',
        relatedSkills: ['empathy', 'communication', 'adaptability'],
      ),
      OnboardingOption(
        id: 'harmony',
        text: 'Найти компромисс, чтобы всем было хорошо',
        emoji: '☮️',
        discType: 'S',
        relatedSkills: ['empathy', 'emotional-regulation', 'resilience'],
      ),
      OnboardingOption(
        id: 'precision',
        text: 'Четкие условия и справедливость для всех',
        emoji: '⚖️',
        discType: 'C',
        relatedSkills: ['critical-thinking', 'planning', 'systems-thinking'],
      ),
    ],
  ),
  OnboardingQuestion(
    id: 'main_goal',
    question: 'Твоя главная цель в Mycelium?',
    emoji: '🎯',
    category: 'goals',
    options: [
      OnboardingOption(
        id: 'career_growth',
        text: 'Развить карьерные навыки',
        emoji: '📈',
        discType: 'D',
        relatedSkills: ['leadership', 'planning', 'execution'],
      ),
      OnboardingOption(
        id: 'networking',
        text: 'Познакомиться с интересными людьми',
        emoji: '🌐',
        discType: 'I',
        relatedSkills: ['communication', 'empathy', 'adaptability'],
      ),
      OnboardingOption(
        id: 'self_improvement',
        text: 'Лучше понять себя и свои эмоции',
        emoji: '🧠',
        discType: 'S',
        relatedSkills: ['self-awareness', 'emotional-regulation', 'resilience'],
      ),
      OnboardingOption(
        id: 'skill_mastery',
        text: 'Освоить конкретные метанавыки',
        emoji: '🎓',
        discType: 'C',
        relatedSkills: ['critical-thinking', 'planning', 'systems-thinking'],
      ),
    ],
  ),
  OnboardingQuestion(
    id: 'conflict_approach',
    question: 'Как ты обычно ведешь себя в конфликте?',
    emoji: '🔥',
    category: 'conflict',
    options: [
      OnboardingOption(
        id: 'confront',
        text: 'Решаю проблему сразу и открыто',
        emoji: '💪',
        discType: 'D',
        relatedSkills: ['leadership', 'decision-making', 'execution'],
      ),
      OnboardingOption(
        id: 'mediate',
        text: 'Стараюсь разрядить обстановку юмором',
        emoji: '😄',
        discType: 'I',
        relatedSkills: ['communication', 'adaptability', 'creativity'],
      ),
      OnboardingOption(
        id: 'avoid',
        text: 'Предпочитаю избежать конфронтации',
        emoji: '🕊️',
        discType: 'S',
        relatedSkills: ['emotional-regulation', 'resilience', 'empathy'],
      ),
      OnboardingOption(
        id: 'analyze',
        text: 'Анализирую факты и ищу справедливое решение',
        emoji: '🔍',
        discType: 'C',
        relatedSkills: ['critical-thinking', 'systems-thinking', 'planning'],
      ),
    ],
  ),
  OnboardingQuestion(
    id: 'learning_style',
    question: 'Как ты предпочитаешь учиться новому?',
    emoji: '📚',
    category: 'learning',
    options: [
      OnboardingOption(
        id: 'doing',
        text: 'Через практику и эксперименты',
        emoji: '🛠️',
        discType: 'D',
        relatedSkills: ['execution', 'adaptability', 'decision-making'],
      ),
      OnboardingOption(
        id: 'discussion',
        text: 'Обсуждая с другими и обмениваясь идеями',
        emoji: '💡',
        discType: 'I',
        relatedSkills: ['communication', 'creativity', 'empathy'],
      ),
      OnboardingOption(
        id: 'observation',
        text: 'Наблюдая за примерами и повторяя',
        emoji: '👀',
        discType: 'S',
        relatedSkills: ['self-awareness', 'resilience', 'adaptability'],
      ),
      OnboardingOption(
        id: 'research',
        text: 'Читая инструкции и изучая теорию',
        emoji: '📖',
        discType: 'C',
        relatedSkills: ['critical-thinking', 'systems-thinking', 'planning'],
      ),
    ],
  ),
];
