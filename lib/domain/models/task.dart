import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;
  @enumerated
  TaskType type;
  String name;
  DateTime date;
  DateTime dateCreated;
  bool isComplete;

  Task(
      {required this.type, required this.name, required this.date, required this.dateCreated, this.isComplete = false});

  Task copyWith({
    TaskType? type,
    String? name,
    DateTime? date,
    DateTime? dateCreated,
    bool? isComplete,
  }) {
    return Task(
      type: type ?? this.type,
      name: name ?? this.name,
      date: date ?? this.date,
      dateCreated: dateCreated ?? this.dateCreated,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}

enum TaskType { work, meeting, home }
