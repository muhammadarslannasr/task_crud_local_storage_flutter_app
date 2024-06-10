import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class Task extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String taskTitle;

  final String taskDescription;

  const Task({
    this.id,
    required this.taskTitle,
    required this.taskDescription,
  });

  @override
  List<Object?> get props => [
        taskTitle,
        taskDescription,
      ];

  @override
  String toString() {
    return 'Task{id: $id, taskTitle: $taskTitle, taskDescription: $taskDescription}';
  }
}
