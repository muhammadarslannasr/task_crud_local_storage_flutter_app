import 'package:flutter_task_crud_local_storage/data/database.dart';
import 'package:flutter_task_crud_local_storage/domain/entities/task.dart';

abstract class LocalDataSource {
  Future<List<Task>> getTasks();

  Future<int> insertTask({required Task task});

  Future<void> deleteTask({required int taskId});

  Future<void> updateTask({required Task task});
}

class LocalDataSourceImpl implements LocalDataSource {
  final AppDatabase database;

  LocalDataSourceImpl({
    required this.database,
  });

  @override
  Future<void> deleteTask({required int taskId}) async {
    try {
      await database.taskDao.delete(taskId);
    } catch (e) {
      throw 'something_went_wrong';
    }
  }

  @override
  Future<List<Task>> getTasks() async {
    try {
      final tasks = await database.taskDao.finalAllTasks();
      return tasks;
    } catch (e) {
      throw [];
    }
  }

  @override
  Future<int> insertTask({required Task task}) async {
    try {
      final result = await database.taskDao.insertTask(task);
      return result;
    } catch (e) {
      throw 'something_went_wrong';
    }
  }

  @override
  Future<void> updateTask({required Task task}) async {
    try {
      await database.taskDao.updateTask(
        task.id!,
        task.taskTitle,
        task.taskDescription,
      );
    } catch (e) {
      throw 'something_went_wrong';
    }
  }
}
