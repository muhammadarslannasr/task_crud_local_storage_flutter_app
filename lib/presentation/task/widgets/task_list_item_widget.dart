import 'package:flutter/material.dart';
import 'package:flutter_task_crud_local_storage/domain/entities/task.dart';

class TaskListItemWidget extends StatelessWidget {
  final Task task;
  final VoidCallback onDeleteTap;
  final VoidCallback onEditTap;
  const TaskListItemWidget({
    super.key,
    required this.task,
    required this.onDeleteTap,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.taskTitle),
      subtitle: Text(task.taskDescription),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onEditTap,
            icon: const Icon(
              Icons.edit,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: onDeleteTap,
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
