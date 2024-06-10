import 'package:floor/floor.dart';
import 'package:flutter_task_crud_local_storage/domain/entities/task.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM task')
  Future<List<Task>> finalAllTasks();

  @insert
  Future<int> insertTask(Task task);

  @Query('DELETE FROM task WHERE id = :id')
  Future<void> delete(int id);

  @Query('UPDATE task SET taskTitle = :taskTitle, taskDescription= :taskDescription WHERE id = :id')
  Future<void> updateTask(
    int id,
    String taskTitle,
    String taskDescription,
  );
}
