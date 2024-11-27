import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';

import '../domain/models/goal.dart';

class GoalBloc extends Cubit<List<Goal>> {
  GoalBloc(this.db) : super([]) {
    getGoals();
  }

  final Isar db;

  void saveGoal(Goal goal) async {
    await db.writeTxn(() async {
      await db.goals.put(goal);
    });
    getGoals();
  }

  void updateGoal(int id, Goal newGoal) async {
    Goal? oldGoal = await db.goals.get(id);
    oldGoal?.name = newGoal.name;
    oldGoal?.type = newGoal.type;
    switch (newGoal.type) {
      case GoalType.fitness:
        oldGoal?.duration = newGoal.duration;
      case GoalType.water:
        oldGoal?.ml = newGoal.ml;
      case GoalType.nutrition:
        oldGoal?.calories = newGoal.calories;
    }
    await db.writeTxn(() async {
      await db.goals.put(oldGoal!);
    });
    getGoals();
  }

  void updateGoalComplete(int id) async {
    Goal? habit = await db.goals.get(id);
    if (habit != null) {
      final currentDay = DateTime.now();

      if (!habit.daysCompleted.any(
        (date) => _isSameDay(date, currentDay),
      )) {
        habit.daysCompleted.add(currentDay);
      }
    }

    await db.writeTxn(() async {
      await db.goals.put(habit!);
    });
    getGoals();
  }

  void deleteGoal(int id) async {
    await db.goals.get(id);
    await db.writeTxn(() async {
      await db.goals.delete(id);
    });
    getGoals();
  }

  void getGoals() async {
    final goals = await db.goals.where().sortByDateCreatedDesc().findAll();
    emit([...goals]);
  }
}

bool _isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
}
