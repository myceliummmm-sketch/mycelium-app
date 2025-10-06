class User {
  final String name;
  final int mycTokens;
  final int streak;
  final int level;
  final int position;
  final double levelProgress; // 0.0 to 1.0

  User({
    required this.name,
    required this.mycTokens,
    required this.streak,
    required this.level,
    required this.position,
    required this.levelProgress,
  });

  User copyWith({
    String? name,
    int? mycTokens,
    int? streak,
    int? level,
    int? position,
    double? levelProgress,
  }) {
    return User(
      name: name ?? this.name,
      mycTokens: mycTokens ?? this.mycTokens,
      streak: streak ?? this.streak,
      level: level ?? this.level,
      position: position ?? this.position,
      levelProgress: levelProgress ?? this.levelProgress,
    );
  }
}
