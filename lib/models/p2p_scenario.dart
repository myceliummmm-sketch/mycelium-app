class P2PScenario {
  final String id;
  final String emoji;
  final String title;
  final String category;
  final String description;
  final bool isSelected;

  const P2PScenario({
    required this.id,
    required this.emoji,
    required this.title,
    required this.category,
    required this.description,
    this.isSelected = false,
  });

  P2PScenario copyWith({
    String? id,
    String? emoji,
    String? title,
    String? category,
    String? description,
    bool? isSelected,
  }) {
    return P2PScenario(
      id: id ?? this.id,
      emoji: emoji ?? this.emoji,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  static List<P2PScenario> getTopScenarios() {
    return [
      const P2PScenario(
        id: 'salary_negotiation',
        emoji: '💰',
        title: 'Переговоры о зарплате',
        category: 'career',
        description: 'Практикуйте обоснование повышения, аргументацию своей ценности и уверенное поведение в переговорах о зарплате',
      ),
      const P2PScenario(
        id: 'difficult_conversation',
        emoji: '💔',
        title: 'Сложный разговор',
        category: 'relationships',
        description: 'Отработайте навык ведения трудных диалогов: говорить о чувствах, слушать партнера и находить решения',
      ),
      const P2PScenario(
        id: 'conflict_resolution',
        emoji: '🔥',
        title: 'Разрешение конфликта',
        category: 'conflict',
        description: 'Научитесь разрешать конфликты конструктивно, находить компромиссы и сохранять отношения',
      ),
      const P2PScenario(
        id: 'job_interview',
        emoji: '👔',
        title: 'Собеседование',
        category: 'career',
        description: 'Потренируйте ответы на сложные вопросы, презентацию своего опыта и уверенное поведение на интервью',
      ),
      const P2PScenario(
        id: 'presentation',
        emoji: '🎤',
        title: 'Презентация',
        category: 'career',
        description: 'Отработайте структуру презентации, работу с вопросами и удержание внимания аудитории',
      ),
      const P2PScenario(
        id: 'set_boundaries',
        emoji: '🚫',
        title: 'Установить границы',
        category: 'relationships',
        description: 'Научитесь говорить "нет", защищать свое время и устанавливать здоровые границы в отношениях',
      ),
      const P2PScenario(
        id: 'pitch_idea',
        emoji: '💡',
        title: 'Питч идеи',
        category: 'career',
        description: 'Потренируйте краткую и убедительную подачу своей идеи, работу с возражениями и вовлечение слушателей',
      ),
      const P2PScenario(
        id: 'empathy_practice',
        emoji: '❤️',
        title: 'Практика эмпатии',
        category: 'emotional',
        description: 'Развивайте способность слышать чувства другого, отражать эмоции и создавать глубокую связь',
      ),
    ];
  }

  static List<P2PScenario> getAllScenarios() {
    return [
      ...getTopScenarios(),
      const P2PScenario(
        id: 'feedback',
        emoji: '📝',
        title: 'Дать фидбэк',
        category: 'career',
        description: 'Практикуйте конструктивную обратную связь: баланс похвалы и критики, конкретика и поддержка роста',
      ),
      const P2PScenario(
        id: 'networking',
        emoji: '🌐',
        title: 'Нетворкинг',
        category: 'social',
        description: 'Развивайте навык знакомства, малого разговора и построения полезных связей естественным образом',
      ),
      const P2PScenario(
        id: 'ask_for_help',
        emoji: '🙏',
        title: 'Попросить помощи',
        category: 'social',
        description: 'Научитесь просить о помощи без чувства вины, формулировать запрос и принимать поддержку',
      ),
      const P2PScenario(
        id: 'creative_brainstorm',
        emoji: '🎨',
        title: 'Креативный штурм',
        category: 'cognitive',
        description: 'Отработайте генерацию идей, латеральное мышление и создание творческих решений в команде',
      ),
      const P2PScenario(
        id: 'say_no',
        emoji: '🙅',
        title: 'Научиться отказывать',
        category: 'relationships',
        description: 'Практикуйте уверенный отказ, сохраняя отношения: вежливо, но твердо защищайте свои интересы',
      ),
      const P2PScenario(
        id: 'conflict_with_boss',
        emoji: '👨‍💼',
        title: 'Конфликт с начальником',
        category: 'conflict',
        description: 'Подготовьтесь к трудному разговору с руководителем: отстоять позицию и сохранить карьеру',
      ),
      const P2PScenario(
        id: 'relationship_future',
        emoji: '💑',
        title: 'Будущее отношений',
        category: 'relationships',
        description: 'Обсудите важные темы о будущем: планы, ценности, ожидания и как двигаться дальше вместе',
      ),
    ];
  }
}
