enum Sphere {
  career('Карьера', '💼'),
  finance('Финансы', '💰'),
  relationships('Отношения', '❤️'),
  health('Здоровье', '🏃'),
  creativity('Творчество', '🎨'),
  learning('Обучение', '📚'),
  growth('Рост', '🌱'),
  goals('Цели', '🎯');

  final String title;
  final String emoji;

  const Sphere(this.title, this.emoji);
}
