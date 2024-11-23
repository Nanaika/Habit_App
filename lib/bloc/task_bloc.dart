import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/domain/models/task.dart';
import 'package:isar/isar.dart';

class TaskBloc extends Cubit<List<Task>> {
  TaskBloc(this.db) : super([]) {
    getTasks();
  }

  final Isar db;

  void saveTask(Task task) async {
    await db.writeTxn(() async {
      await db.tasks.put(task);
    });
    getTasks();
  }

  void updateTaskComplete(int id, bool isComplete) async {
    Task? task = await db.tasks.get(id);
    task?.isComplete = isComplete;
    await db.writeTxn(() async {
      await db.tasks.put(task!);
    });
    getTasks();
  }

  void deleteTask(int id) async {
    await db.tasks.get(id);
    await db.writeTxn(() async {
      await db.tasks.delete(id);
    });

    getTasks();
  }

  void getTasks() async {
    final tasks = await db.tasks.where().sortByDateCreatedDesc().findAll();
    emit([...tasks]);
  }
}
