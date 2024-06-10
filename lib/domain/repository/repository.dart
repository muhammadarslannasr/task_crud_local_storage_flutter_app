import 'package:flutter_task_crud_local_storage/data/datasources/local_data_source.dart';
import 'package:flutter_task_crud_local_storage/domain/entities/task.dart';

abstract class Repository {
  Future<int> insertTask({required Task task});

  Future<List<Task>> getAllTasks();

  Future<void> deleteTask({required int taskId});

  Future<void> updateTask({required Task task});
}

class RepositoryImpl extends Repository {
  final LocalDataSource localDataSource;

  RepositoryImpl({required this.localDataSource});

  @override
  Future<void> deleteTask({required int taskId}) async {
    try {
      await localDataSource.deleteTask(taskId: taskId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Task>> getAllTasks() async {
    try {
      final tasks = await localDataSource.getTasks();
      return tasks;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> insertTask({required Task task}) async {
    try {
      final result = await localDataSource.insertTask(task: task);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateTask({required Task task}) async {
    try {
      await localDataSource.updateTask(task: task);
    } catch (e) {
      rethrow;
    }
  }
}
