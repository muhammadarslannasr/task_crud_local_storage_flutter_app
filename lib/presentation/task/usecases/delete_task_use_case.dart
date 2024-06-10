import 'package:flutter_task_crud_local_storage/domain/repository/repository.dart';
import 'package:flutter_task_crud_local_storage/domain/usecase/usecase.dart';

class DeleteTaskUseCase extends UseCase<int, void> {
  final Repository repository;

  DeleteTaskUseCase({required this.repository});

  @override
  Future<void> call(int params) {
    return repository.deleteTask(taskId: params);
  }
}
