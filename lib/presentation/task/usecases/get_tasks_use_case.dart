import 'package:flutter_task_crud_local_storage/domain/entities/task.dart';
import 'package:flutter_task_crud_local_storage/domain/repository/repository.dart';
import 'package:flutter_task_crud_local_storage/domain/usecase/usecase.dart';

class GetTasksUseCase extends UseCase<NoParams, List<Task>> {
  final Repository repository;

  GetTasksUseCase({required this.repository});

  @override
  Future<List<Task>> call(NoParams params) {
    return repository.getAllTasks();
  }
}
