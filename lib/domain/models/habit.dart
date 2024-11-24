import 'package:isar/isar.dart';

part 'habit.g.dart';

@collection
class Habit {
  Id id = Isar.autoIncrement;
  String name;
  @enumerated
  HabitType type;
  int numOfRepetition;
  @enumerated
  HabitCategory category;
  DateTime dateCreated;
  bool isComplete;
  List<DateTime> daysComplete;
  List<int> weeksComplete;

  Habit({
    required this.name,
    required this.type,
    required this.numOfRepetition,
    required this.category,
    required this.dateCreated,
    this.isComplete = false,
    required this.daysComplete,
    required this.weeksComplete,
  });

  Habit copyWith({
    String? name,
    HabitType? type,
    int? numOfRepetition,
    HabitCategory? category,
    DateTime? dateCreated,
    bool? isComplete,
    List<DateTime>? daysComplete,
    List<int>? weeksComplete,
  }) {
    return Habit(
      name: name ?? this.name,
      type: type ?? this.type,
      numOfRepetition: numOfRepetition ?? this.numOfRepetition,
      category: category ?? this.category,
      dateCreated: dateCreated ?? this.dateCreated,
      isComplete: isComplete ?? this.isComplete,
      daysComplete: daysComplete ?? this.daysComplete,
      weeksComplete: weeksComplete ?? this.weeksComplete,
    );
  }

  @override
  String toString() {
    return 'Habit{id: $id, name: $name, type: $type, numOfRepetition: $numOfRepetition, category: $category, dateCreated: $dateCreated, isComplete: $isComplete}';
  }
}

enum HabitCategory { sport, nutrition, sleep, meditation, reading, creativity, other }

enum HabitType { daily, weekly }
