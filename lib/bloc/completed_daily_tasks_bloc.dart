import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/domain/models/task.dart';
import 'package:isar/isar.dart';

class CompletedDailyTasksBloc extends Cubit<List<Task>> {
  CompletedDailyTasksBloc(this.db) : super([]);

  final Isar db;

  void getTasksByType(TaskType type) async {
    final tasks = await db.tasks.filter().typeEqualTo(type).findAll();
    emit(tasks);
  }
}
