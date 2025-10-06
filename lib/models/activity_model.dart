enum ActivityType {
  testCompleted,
  p2pCall,
  levelUp,
  achievement,
}

class ActivityModel {
  final String id;
  final ActivityType type;
  final String title;
  final String description;
  final String aiComment;
  final String timestamp;
  final String? emoji;
  final Map<String, dynamic>? metadata;

  const ActivityModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.aiComment,
    required this.timestamp,
    this.emoji,
    this.metadata,
  });
}
