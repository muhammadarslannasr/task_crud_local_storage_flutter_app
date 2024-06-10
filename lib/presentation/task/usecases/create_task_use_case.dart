import 'package:flutter_task_crud_local_storage/domain/entities/task.dart';
import 'package:flutter_task_crud_local_storage/domain/repository/repository.dart';
import 'package:flutter_task_crud_local_storage/domain/usecase/usecase.dart';

class CreateTaskUseCase extends UseCase<Task, int> {
  final Repository repository;
  CreateTaskUseCase({required this.repository});

  @override
  Future<int> call(Task params) {
    return repository.insertTask(task: params);
  }
}
