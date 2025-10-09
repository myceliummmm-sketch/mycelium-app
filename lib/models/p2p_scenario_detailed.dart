class P2PRole {
  final String name;
  final List<String> info;
  final String goal;
  final List<String> secrets;

  const P2PRole({
    required this.name,
    required this.info,
    required this.goal,
    required this.secrets,
  });
}

class P2PScenarioDetailed {
  final String id;
  final String emoji;
  final String title;
  final String skill;
  final String sphere;
  final String question;
  final String description;
  final P2PRole roleA;
  final P2PRole roleB;

  const P2PScenarioDetailed({
    required this.id,
    required this.emoji,
    required this.title,
    required this.skill,
    required this.sphere,
    required this.question,
    required this.description,
    required this.roleA,
    required this.roleB,
  });

  static List<P2PScenarioDetailed> getTopScenarios() {
    return [
      const P2PScenarioDetailed(
        id: '1',
        emoji: '💰',
        title: 'Битва за зарплату',
        skill: 'Переговоры',
        sphere: 'Деньги',
        question: 'Готов попросить повышение на 40% у скептичного босса?',
        description: 'Твоя работа отличная, но компания в кризисе. Нужно убедить руководителя.',
        roleA: P2PRole(
          name: 'Сотрудник',
          info: [
            '3 успешных продукта за год',
            'Есть оффер конкурента на 200К',
            'Критично нужны деньги'
          ],
          goal: '150К → 210К руб',
          secrets: [
            'Оффер есть, но хочешь остаться',
            'Ипотека + ребёнок',
            'Минимум 180К или уход'
          ],
        ),
        roleB: P2PRole(
          name: 'Руководитель',
          info: [
            'Ценит сотрудника',
            'Бюджет урезан',
            'CEO запретил >15%'
          ],
          goal: 'Сохранить при +15%',
          secrets: [
            'Знаешь об офере',
            'Потеря = 500К убытков',
            'MAX 165К базы'
          ],
        ),
      ),
      const P2PScenarioDetailed(
        id: '2',
        emoji: '💔',
        title: 'Неудобная правда',
        skill: 'Аутентичность',
        sphere: 'Отношения',
        question: 'Готов сказать партнёру что чувства остыли?',
        description: '6 месяцев вместе, но последнее время холодно. Пора говорить честно.',
        roleA: P2PRole(
          name: 'Партнёр A',
          info: [
            'Инициатор разговора',
            'Чувствует охлаждение',
            'Хочет честности'
          ],
          goal: 'Понять, продолжать ли',
          secrets: [
            'Месяц думаешь о расставании',
            'Друзья считают вас идеальными',
            'Страшно причинить боль'
          ],
        ),
        roleB: P2PRole(
          name: 'Партнёр B',
          info: [
            'Заметил дистанцию',
            'Готов меняться',
            'Хочет сохранить'
          ],
          goal: 'Вернуть близость',
          secrets: [
            'Встретил интересного человека',
            'Ничего не было, но мысли есть',
            'Мучает вина'
          ],
        ),
      ),
      const P2PScenarioDetailed(
        id: '3',
        emoji: '🚀',
        title: 'Стартап или провал',
        skill: 'Креативность',
        sphere: 'Деньги',
        question: 'Готов придумать революционную бизнес-идею за 20 минут?',
        description: 'Стартап на грани краха. Инвестор даёт последний шанс.',
        roleA: P2PRole(
          name: 'Стартапер',
          info: [
            'Деньги кончаются через месяц',
            'Текущая модель не работает',
            'Нужны \$100K'
          ],
          goal: 'Получить инвестиции',
          secrets: [
            'Конкурент через 2 недели',
            'Команда на грани ухода',
            'MAX 40% компании'
          ],
        ),
        roleB: P2PRole(
          name: 'Инвестор',
          info: [
            'Устал от клонов',
            'Ищет уникальное',
            'Готов рискнуть'
          ],
          goal: 'Найти 10x идею',
          secrets: [
            'Потерял \$500K на похожем',
            'Партнёры давят',
            'Нужен proof of concept'
          ],
        ),
      ),
    ];
  }
}
