enum MetaskillDomain {
  cognitive('Когнитивные', '🧠'),
  social('Социальные', '👥'),
  emotional('Эмоциональные', '💝'),
  practical('Практические', '🛠️');

  final String title;
  final String emoji;

  const MetaskillDomain(this.title, this.emoji);
}

enum Metaskill {
  // Cognitive domain
  criticalThinking('Критическое мышление', MetaskillDomain.cognitive),
  creativity('Креативность', MetaskillDomain.cognitive),
  systemsThinking('Системное мышление', MetaskillDomain.cognitive),
  learning('Обучаемость', MetaskillDomain.cognitive),

  // Social domain
  communication('Коммуникация', MetaskillDomain.social),
  collaboration('Сотрудничество', MetaskillDomain.social),
  leadership('Лидерство', MetaskillDomain.social),
  empathy('Эмпатия', MetaskillDomain.social),

  // Emotional domain
  selfAwareness('Самосознание', MetaskillDomain.emotional),
  emotionalRegulation('Эмоциональная регуляция', MetaskillDomain.emotional),
  resilience('Стрессоустойчивость', MetaskillDomain.emotional),
  motivation('Мотивация', MetaskillDomain.emotional),

  // Practical domain
  adaptability('Адаптивность', MetaskillDomain.practical),
  planning('Планирование', MetaskillDomain.practical),
  decisionMaking('Принятие решений', MetaskillDomain.practical),
  execution('Исполнение', MetaskillDomain.practical);

  final String title;
  final MetaskillDomain domain;

  const Metaskill(this.title, this.domain);
}
