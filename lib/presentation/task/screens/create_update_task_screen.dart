import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_crud_local_storage/domain/entities/task.dart';
import 'package:flutter_task_crud_local_storage/presentation/task/bloc/task_bloc.dart';
import 'package:flutter_task_crud_local_storage/utils/utils.dart';

class CreateUpdateTaskScreen extends StatefulWidget {
  final CreateOrUpdateTaskEnum createOrUpdateTaskEnum;
  final int id;
  final String taskTitle;
  final String taskDescription;
  const CreateUpdateTaskScreen({
    super.key,
    required this.createOrUpdateTaskEnum,
    this.id = 0,
    this.taskTitle = '',
    this.taskDescription = '',
  });

  @override
  State<CreateUpdateTaskScreen> createState() => _CreateUpdateTaskScreenState();
}

class _CreateUpdateTaskScreenState extends State<CreateUpdateTaskScreen> {
  final TextEditingController _taskTitleController = TextEditingController();

  final TextEditingController _taskDescriptionController = TextEditingController();

  @override
  void initState() {
    ///* setup value if enum is for update && for create enum no need!
    initializeControllersSetupValues();

    _taskTitleController.addListener(() {
      setState(() {});
    });

    _taskDescriptionController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  initializeControllersSetupValues() {
    if (widget.createOrUpdateTaskEnum == CreateOrUpdateTaskEnum.update) {
      _taskTitleController.text = widget.taskTitle;
      _taskDescriptionController.text = widget.taskDescription;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _taskTitleController.dispose();
    _taskDescriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskBlocState>(
      listener: (context, state) {
        if (state is TaskCreatedBlocSuccessState) {
          context.read<TaskBloc>().add(GetTasksBlocEvent());
          Navigator.pop(context);
        }

        if (state is TaskCreatedBlocFailureState) {
          debugPrint('Error: ${state.errMsg}');
        }

        if (state is TaskUpdatedBlocSuccessState) {
          context.read<TaskBloc>().add(GetTasksBlocEvent());
          Navigator.pop(context);
        }

        if (state is TaskUpdatedBlocFailureState) {
          debugPrint('Error: ${state.errMsg}');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Utils.getCreateOrUpdateScreenPageTitle(createOrUpdateTaskEnum: widget.createOrUpdateTaskEnum),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 12),
              TextFormField(
                controller: _taskTitleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  labelText: 'Task Title',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _taskDescriptionController,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  labelText: 'Task Description',
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: disableButton() ? null : () => createOrUpdateOnPress(),
                child: Container(
                  color: disableButton() ? Colors.grey : Colors.black,
                  width: 327,
                  height: 48,
                  alignment: Alignment.center,
                  child: Text(
                    Utils.getCreateOrUpdateScreenButtonTitle(createOrUpdateTaskEnum: widget.createOrUpdateTaskEnum),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool disableButton() {
    bool isDisable = _taskTitleController.text.isEmpty || _taskDescriptionController.text.isEmpty;
    return isDisable;
  }

  void createOrUpdateOnPress() {
    switch (widget.createOrUpdateTaskEnum) {
      case CreateOrUpdateTaskEnum.create:
        context.read<TaskBloc>().add(
              CreateTaskBlocEvent(
                taskTitle: _taskTitleController.text,
                taskDescription: _taskDescriptionController.text,
              ),
            );
      case CreateOrUpdateTaskEnum.update:
        context.read<TaskBloc>().add(
              UpdateTaskBlocEvent(
                task: Task(
                  id: widget.id,
                  taskTitle: _taskTitleController.text,
                  taskDescription: _taskDescriptionController.text,
                ),
              ),
            );
    }
  }
}

enum CreateOrUpdateTaskEnum { create, update }
