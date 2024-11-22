class Goal {
  final GoalType type;
  final String name;
  final Duration duration;
  final DateTime dateCreated;
  final int completed;
  final List<DateTime> daysCompleted;

  Goal(
      {required this.type,
      required this.name,
      required this.duration,
      required this.dateCreated,
      required this.completed,
      required this.daysCompleted});
}

enum GoalType { fitness, water, nutrition }
