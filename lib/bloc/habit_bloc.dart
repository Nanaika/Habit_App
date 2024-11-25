import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/utils/utils.dart';
import 'package:isar/isar.dart';

import '../domain/models/habit.dart';

class HabitBloc extends Cubit<List<Habit>> {
  HabitBloc(this.db) : super([]) {
    getHabits();
  }

  final Isar db;

  void saveHabit(Habit habit) async {
    await db.writeTxn(() async {
      await db.habits.put(habit);
    });
    getHabits();
  }

  void updateHabit(int id, Habit newHabit) async {
    Habit? oldHabit = await db.habits.get(id);
    oldHabit?.name = newHabit.name;
    oldHabit?.numOfRepetition = newHabit.numOfRepetition;
    oldHabit?.type = newHabit.type;
    oldHabit?.category = newHabit.category;
    await db.writeTxn(() async {
      await db.habits.put(oldHabit!);
    });
    getHabits();
  }

  void updateHabitComplete(int id, bool isComplete) async {
    Habit? habit = await db.habits.get(id);
    if (habit != null) {
      final currentDay = DateTime.now();
      if (isComplete) {
        if (habit.type == HabitType.daily) {
          if (!habit.daysComplete.any(
            (date) => _isSameDay(date, currentDay),
          )) {
            habit.daysComplete.add(currentDay);
          }
        } else {
          //TODO

          if (!habit.weeksComplete.any(
            (date) => date == getWeekOfYear(currentDay),
          )) {
            habit.weeksComplete.add(getWeekOfYear(currentDay));
          }

          //TODO
        }
      } else {
        if (habit.type == HabitType.daily) {
          habit.daysComplete.removeWhere((date) => _isSameDay(date, currentDay));
        } else {
          habit.weeksComplete.removeWhere((date) => date == getWeekOfYear(currentDay));
        }
      }
    }

    habit?.isComplete = isComplete;
    await db.writeTxn(() async {
      await db.habits.put(habit!);
    });
    getHabits();
  }

  void deleteHabit(int id) async {
    await db.habits.get(id);
    await db.writeTxn(() async {
      await db.habits.delete(id);
    });
    getHabits();
  }

  void getHabits() async {
    final habits = await db.habits.where().sortByDateCreatedDesc().findAll();
    emit([...habits]);
  }
}

bool _isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
}
