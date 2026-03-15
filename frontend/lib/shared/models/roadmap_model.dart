class RoadmapStage {
  final String id;
  final String title;
  final String description;
  final String xp;
  final int orderIndex;
  final bool isCompleted;
  final bool isLocked;
  final bool isActive;
  final List<RoadmapTask> tasks;
  final String? question;
  final String? answer;

  RoadmapStage({
    required this.id,
    required this.title,
    required this.description,
    required this.xp,
    required this.orderIndex,
    this.isCompleted = false,
    this.isLocked = false,
    this.isActive = false,
    required this.tasks,
    this.question,
    this.answer,
  });

  factory RoadmapStage.fromJson(
    Map<String, dynamic> json, {
    bool isCompleted = false,
    bool isLocked = false,
    bool isActive = false,
    List<RoadmapTask> tasks = const [],
  }) {
    return RoadmapStage(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      xp: json['xp_reward'] ?? '0 XP',
      orderIndex: json['order_index'] ?? 0,
      isCompleted: isCompleted,
      isLocked: isLocked,
      isActive: isActive,
      tasks: tasks,
      question: json['question'],
      answer: json['answer'],
    );
  }
}

class RoadmapTask {
  final String id;
  final String title;
  final String description;
  final String xp;
  final String state; // 'completed', 'active', 'locked'

  RoadmapTask({
    required this.id,
    required this.title,
    required this.description,
    required this.xp,
    required this.state,
  });

  factory RoadmapTask.fromJson(
    Map<String, dynamic> json, {
    String state = 'locked',
  }) {
    return RoadmapTask(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      xp: json['xp_reward'] ?? '0 XP',
      state: state,
    );
  }
}
