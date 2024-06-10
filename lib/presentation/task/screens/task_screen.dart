import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_crud_local_storage/domain/entities/task.dart';
import 'package:flutter_task_crud_local_storage/presentation/task/bloc/task_bloc.dart';
import 'package:flutter_task_crud_local_storage/presentation/task/screens/create_update_task_screen.dart';
import 'package:flutter_task_crud_local_storage/presentation/task/widgets/empty_view_widget.dart';
import 'package:flutter_task_crud_local_storage/presentation/task/widgets/task_list_item_widget.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(GetTasksBlocEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateUpdateTaskScreen(
                createOrUpdateTaskEnum: CreateOrUpdateTaskEnum.create,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TaskBloc, TaskBlocState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.errMsg.isNotEmpty) {
            return Center(
              child: Text(state.errMsg),
            );
          } else {
            return state.taskList.isEmpty
                ? const EmptyViewWidget()
                : ListView.builder(
                    itemCount: state.taskList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Task task = state.taskList[index];

                      return TaskListItemWidget(
                        onEditTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CreateUpdateTaskScreen(
                                createOrUpdateTaskEnum: CreateOrUpdateTaskEnum.update,
                                id: task.id!,
                                taskTitle: task.taskTitle,
                                taskDescription: task.taskDescription,
                              ),
                            ),
                          );
                        },
                        onDeleteTap: () => context.read<TaskBloc>().add(DeleteTaskBlocEvent(id: task.id!)),
                        task: task,
                      );
                    },
                  );
          }
        },
      ),
    );
  }
}
