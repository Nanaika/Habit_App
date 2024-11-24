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

  Habit({
    required this.name,
    required this.type,
    required this.numOfRepetition,
    required this.category,
    required this.dateCreated,
    this.isComplete = false,
  });

  Habit copyWith({
    String? name,
    HabitType? type,
    int? numOfRepetition,
    HabitCategory? category,
    DateTime? dateCreated,
    bool? isComplete,
  }) {
    return Habit(
      name: name ?? this.name,
      type: type ?? this.type,
      numOfRepetition: numOfRepetition ?? this.numOfRepetition,
      category: category ?? this.category,
      dateCreated: dateCreated ?? this.dateCreated,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  @override
  String toString() {
    return 'Habit{id: $id, name: $name, type: $type, numOfRepetition: $numOfRepetition, category: $category, dateCreated: $dateCreated, isComplete: $isComplete}';
  }
}

enum HabitCategory { sport, nutrition, sleep, meditation, reading, creativity, other }

enum HabitType { daily, weekly }
