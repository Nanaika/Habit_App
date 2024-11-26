import 'package:isar/isar.dart';

part 'goal.g.dart';

@collection
class Goal {
  Id id = Isar.autoIncrement;
  @enumerated
  GoalType type;
  String name;
  CustomDuration? duration;
  int? ml;
  int? calories;
  DateTime dateCreated;
  int completedTimes;
  List<DateTime> daysCompleted;

  Goal(
      {required this.type,
      required this.name,
      this.duration,
      this.ml,
      this.calories,
      required this.dateCreated,
      required this.completedTimes,
      required this.daysCompleted});

  @override
  String toString() {
    return 'Goal(type: $type, name: $name, duration: ${duration ?? 'N/A'}, ml: ${ml ?? 'N/A'}, '
        'calories: ${calories ?? 'N/A'}, dateCreated: ${dateCreated.toIso8601String()}, '
        'completedTimes: $completedTimes, daysCompleted: ${daysCompleted.map((d) => d.toIso8601String()).toList()})';
  }

}
@embedded
class CustomDuration {
  final int hours;
  final int minutes;

  CustomDuration({this.hours = 0, this.minutes = 0});
}

enum GoalType { fitness, water, nutrition }
