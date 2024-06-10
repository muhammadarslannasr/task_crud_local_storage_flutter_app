import 'package:flutter_task_crud_local_storage/domain/entities/task.dart';
import 'package:flutter_task_crud_local_storage/domain/repository/repository.dart';
import 'package:flutter_task_crud_local_storage/domain/usecase/usecase.dart';

class EditTaskUseCase extends UseCase<Task, void> {
  final Repository repository;

  EditTaskUseCase({required this.repository});

  @override
  Future<void> call(Task params) {
    return repository.updateTask(task: params);
  }
}
