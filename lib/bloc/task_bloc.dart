import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/domain/models/task.dart';
import 'package:isar/isar.dart';

class TaskBloc extends Cubit<MyTasks> {
  TaskBloc(this.db)
      : super(
          MyTasks(
            dailyTasks: [],
            weeklyTasks: [],
            completedDailyTasks:
                CompletedDailyTasks(workCompletedTasks: [], meetingsCompletedTasks: [], homeCompletedTasks: []),
          ),
        ) {
    getDailyTasks();
    getWeeklyTasks();
    getTodayCompletedTasks(TaskType.work);
    getTodayCompletedTasks(TaskType.meeting);
    getTodayCompletedTasks(TaskType.home);
  }

  final Isar db;

  void getTodayCompletedTasks(TaskType type) async {
    final today = DateTime.now();

    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1)).subtract(const Duration(milliseconds: 1));

    final tasks = await db.tasks.filter().typeEqualTo(type).sortByDateCreatedDesc().findAll();

    final todayTasks = tasks.where((task) {
      return task.date.isAfter(startOfDay.subtract(const Duration(days: 1))) &&
          task.date.isBefore(endOfDay.add(const Duration(days: 1)));
    }).toList();
    final totalTasks = todayTasks.length;
    final completedTasks = todayTasks.where((task) => task.isComplete).toList();

    switch (type) {
      case TaskType.work:
        emit(MyTasks(
            dailyTasks: state.dailyTasks,
            weeklyTasks: state.weeklyTasks,
            completedDailyTasks: CompletedDailyTasks(
                workTasksLength: totalTasks,
                meetingsTasksLength: state.completedDailyTasks.meetingsTasksLength,
                homeTasksLength: state.completedDailyTasks.homeTasksLength,
                workCompletedTasks: completedTasks,
                meetingsCompletedTasks: state.completedDailyTasks.meetingsCompletedTasks,
                homeCompletedTasks: state.completedDailyTasks.homeCompletedTasks)));
      case TaskType.meeting:
        emit(MyTasks(
            dailyTasks: state.dailyTasks,
            weeklyTasks: state.weeklyTasks,
            completedDailyTasks: CompletedDailyTasks(
                workTasksLength: state.completedDailyTasks.workTasksLength,
                meetingsTasksLength: totalTasks,
                homeTasksLength: state.completedDailyTasks.homeTasksLength,
                workCompletedTasks: state.completedDailyTasks.workCompletedTasks,
                meetingsCompletedTasks: completedTasks,
                homeCompletedTasks: state.completedDailyTasks.homeCompletedTasks)));
      case TaskType.home:
        emit(MyTasks(
            dailyTasks: state.dailyTasks,
            weeklyTasks: state.weeklyTasks,
            completedDailyTasks: CompletedDailyTasks(
                workTasksLength: state.completedDailyTasks.workTasksLength,
                meetingsTasksLength: state.completedDailyTasks.meetingsTasksLength,
                homeTasksLength: totalTasks,
                workCompletedTasks: state.completedDailyTasks.workCompletedTasks,
                meetingsCompletedTasks: state.completedDailyTasks.meetingsCompletedTasks,
                homeCompletedTasks: completedTasks)));
    }
  }

  void saveTask(Task task) async {
    await db.writeTxn(() async {
      await db.tasks.put(task);
    });
    getDailyTasks();
    getWeeklyTasks();
    getTodayCompletedTasks(TaskType.work);
    getTodayCompletedTasks(TaskType.meeting);
    getTodayCompletedTasks(TaskType.home);
  }

  void updateTaskComplete(int id, bool isComplete) async {
    Task? task = await db.tasks.get(id);
    task?.isComplete = isComplete;
    await db.writeTxn(() async {
      await db.tasks.put(task!);
    });
    getDailyTasks();
    getWeeklyTasks();
    getTodayCompletedTasks(TaskType.work);
    getTodayCompletedTasks(TaskType.meeting);
    getTodayCompletedTasks(TaskType.home);
  }

  void deleteTask(int id) async {
    await db.tasks.get(id);
    await db.writeTxn(() async {
      await db.tasks.delete(id);
    });

    getDailyTasks();
    getWeeklyTasks();
    getTodayCompletedTasks(TaskType.work);
    getTodayCompletedTasks(TaskType.meeting);
    getTodayCompletedTasks(TaskType.home);
  }

  void getDailyTasks() async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59);

    final tasks = await db.tasks.filter().dateBetween(startOfDay, endOfDay).sortByDateCreatedDesc().findAll();

    emit(MyTasks(dailyTasks: tasks, weeklyTasks: state.weeklyTasks, completedDailyTasks: state.completedDailyTasks));
  }

  void getWeeklyTasks() async {
    final today = DateTime.now();

    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    final tasks = await db.tasks.where().sortByDateCreatedDesc().findAll();

    final weeklyTasks = tasks.where((task) {
      return task.date.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
          task.date.isBefore(endOfWeek.add(const Duration(days: 1)));
    }).toList();

    emit(MyTasks(
        dailyTasks: state.dailyTasks, weeklyTasks: weeklyTasks, completedDailyTasks: state.completedDailyTasks));
  }
}

class MyTasks {
  List<Task> dailyTasks;
  List<Task> weeklyTasks;
  CompletedDailyTasks completedDailyTasks;

  MyTasks({required this.dailyTasks, required this.weeklyTasks, required this.completedDailyTasks});
}

class CompletedDailyTasks {
  int workTasksLength;
  int meetingsTasksLength;
  int homeTasksLength;
  List<Task> workCompletedTasks;
  List<Task> meetingsCompletedTasks;
  List<Task> homeCompletedTasks;

  CompletedDailyTasks(
      {required this.workCompletedTasks,
      required this.meetingsCompletedTasks,
      required this.homeCompletedTasks,
      this.workTasksLength = 0,
      this.meetingsTasksLength = 0,
      this.homeTasksLength = 0});
}
