class User {
  final String id;
  final int telegramId;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? photoUrl;
  final int mycTokens;
  final int level;
  final double levelProgress; // 0.0 to 1.0
  final int streakDays;
  final int xp; // experience points
  final double trustScore; // 0-100
  final List<MetaskillScore>? metaskills;
  final UserStats? stats;

  User({
    required this.id,
    required this.telegramId,
    this.username,
    this.firstName,
    this.lastName,
    this.photoUrl,
    required this.mycTokens,
    required this.level,
    required this.levelProgress,
    required this.streakDays,
    this.xp = 0,
    this.trustScore = 100.0,
    this.metaskills,
    this.stats,
  });

  String get displayName {
    if (firstName != null) {
      return lastName != null ? '$firstName $lastName' : firstName!;
    }
    return username ?? 'User $telegramId';
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      telegramId: json['telegramId'] as int,
      username: json['username'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      mycTokens: json['mycTokens'] as int? ?? 0,
      level: json['level'] as int? ?? 1,
      levelProgress: (json['levelProgress'] as num?)?.toDouble() ?? 0.0,
      streakDays: json['streakDays'] as int? ?? 0,
      xp: json['xp'] as int? ?? 0,
      trustScore: (json['trustScore'] as num?)?.toDouble() ?? 100.0,
      metaskills: json['metaskills'] != null
          ? (json['metaskills'] as List)
              .map((m) => MetaskillScore.fromJson(m))
              .toList()
          : null,
      stats: json['stats'] != null
          ? UserStats.fromJson(json['stats'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'telegramId': telegramId,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'photoUrl': photoUrl,
      'mycTokens': mycTokens,
      'level': level,
      'levelProgress': levelProgress,
      'streakDays': streakDays,
      'xp': xp,
      'trustScore': trustScore,
      'metaskills': metaskills?.map((m) => m.toJson()).toList(),
      'stats': stats?.toJson(),
    };
  }

  User copyWith({
    String? id,
    int? telegramId,
    String? username,
    String? firstName,
    String? lastName,
    String? photoUrl,
    int? mycTokens,
    int? level,
    double? levelProgress,
    int? streakDays,
    int? xp,
    double? trustScore,
    List<MetaskillScore>? metaskills,
    UserStats? stats,
  }) {
    return User(
      id: id ?? this.id,
      telegramId: telegramId ?? this.telegramId,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      photoUrl: photoUrl ?? this.photoUrl,
      mycTokens: mycTokens ?? this.mycTokens,
      level: level ?? this.level,
      levelProgress: levelProgress ?? this.levelProgress,
      streakDays: streakDays ?? this.streakDays,
      xp: xp ?? this.xp,
      trustScore: trustScore ?? this.trustScore,
      metaskills: metaskills ?? this.metaskills,
      stats: stats ?? this.stats,
    );
  }
}

class MetaskillScore {
  final String id;
  final String userId;
  final String domain;
  final String skill;
  final double score;
  final DateTime? updatedAt;

  MetaskillScore({
    required this.id,
    required this.userId,
    required this.domain,
    required this.skill,
    required this.score,
    this.updatedAt,
  });

  factory MetaskillScore.fromJson(Map<String, dynamic> json) {
    return MetaskillScore(
      id: json['id'] as String,
      userId: json['userId'] as String,
      domain: json['domain'] as String,
      skill: json['skill'] as String,
      score: (json['score'] as num).toDouble(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'domain': domain,
      'skill': skill,
      'score': score,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class UserStats {
  final int testsCompleted;
  final int p2pCalls;
  final int achievements;

  UserStats({
    required this.testsCompleted,
    required this.p2pCalls,
    required this.achievements,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      testsCompleted: json['testsCompleted'] as int? ?? 0,
      p2pCalls: json['p2pCalls'] as int? ?? 0,
      achievements: json['achievements'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'testsCompleted': testsCompleted,
      'p2pCalls': p2pCalls,
      'achievements': achievements,
    };
  }
}
