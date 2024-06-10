import 'package:flutter_task_crud_local_storage/presentation/task/screens/create_update_task_screen.dart';

class Utils {
  static String getCreateOrUpdateScreenPageTitle({required CreateOrUpdateTaskEnum createOrUpdateTaskEnum}) {
    switch (createOrUpdateTaskEnum) {
      case CreateOrUpdateTaskEnum.create:
        return 'Create Task';
      case CreateOrUpdateTaskEnum.update:
        return 'Edit Task';
      default:
        return '';
    }
  }

  static String getCreateOrUpdateScreenButtonTitle({required CreateOrUpdateTaskEnum createOrUpdateTaskEnum}) {
    switch (createOrUpdateTaskEnum) {
      case CreateOrUpdateTaskEnum.create:
        return 'Create';
      case CreateOrUpdateTaskEnum.update:
        return 'Edit';
      default:
        return '';
    }
  }
}
