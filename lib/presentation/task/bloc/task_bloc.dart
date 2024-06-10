import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_crud_local_storage/domain/entities/task.dart';
import 'package:flutter_task_crud_local_storage/domain/usecase/usecase.dart';
import 'package:flutter_task_crud_local_storage/presentation/task/usecases/create_task_use_case.dart';
import 'package:flutter_task_crud_local_storage/presentation/task/usecases/delete_task_use_case.dart';
import 'package:flutter_task_crud_local_storage/presentation/task/usecases/edit_task_use_case.dart';
import 'package:flutter_task_crud_local_storage/presentation/task/usecases/get_tasks_use_case.dart';

class TaskBloc extends Bloc<TaskBlocEvent, TaskBlocState> {
  final GetTasksUseCase getTasksUseCase;
  final CreateTaskUseCase createTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final EditTaskUseCase editTaskUseCase;

  TaskBloc({
    required this.getTasksUseCase,
    required this.createTaskUseCase,
    required this.deleteTaskUseCase,
    required this.editTaskUseCase,
  }) : super(TaskBlocChangeState.initial()) {
    on<GetTasksBlocEvent>(_getTasksBlocEvent);
    on<CreateTaskBlocEvent>(_createTaskBlocEvent);
    on<DeleteTaskBlocEvent>(_deleteTaskBlocEvent);
    on<UpdateTaskBlocEvent>(_updateTaskBlocEvent);
  }

  FutureOr<void> _getTasksBlocEvent(GetTasksBlocEvent event, Emitter<TaskBlocState> emit) async {
    getBlocState(loading: true);

    try {
      final tasks = await getTasksUseCase.call(NoParams());

      emit(getBlocState(loading: false, taskList: tasks));
    } catch (_) {
      emit(getBlocState(loading: false, errMsg: _.toString()));
    }
  }

  FutureOr<void> _createTaskBlocEvent(CreateTaskBlocEvent event, Emitter<TaskBlocState> emit) async {
    getBlocState(loading: true);

    try {
      final _ = await createTaskUseCase.call(Task(taskTitle: event.taskTitle, taskDescription: event.taskDescription));

      emit(
        TaskCreatedBlocSuccessState(
          loading: false,
          errMsg: '',
          taskList: state.taskList,
        ),
      );
    } catch (_) {
      emit(
        TaskCreatedBlocFailureState(
          loading: false,
          errMsg: _.toString(),
          taskList: state.taskList,
        ),
      );
    }
  }

  FutureOr<void> _deleteTaskBlocEvent(DeleteTaskBlocEvent event, Emitter<TaskBlocState> emit) async {
    ///* delete item from database then from then get updated data from database.
    try {
      await deleteTaskUseCase.call(event.id);

      add(GetTasksBlocEvent());
    } catch (e) {
      emit(getBlocState(errMsg: e.toString()));
    }
  }

  FutureOr<void> _updateTaskBlocEvent(UpdateTaskBlocEvent event, Emitter<TaskBlocState> emit) async {
    try {
      await editTaskUseCase.call(
        Task(
          id: event.task.id!,
          taskTitle: event.task.taskTitle,
          taskDescription: event.task.taskDescription,
        ),
      );

      emit(TaskUpdatedBlocSuccessState(
        loading: state.loading,
        errMsg: '',
        taskList: state.taskList,
      ));
    } catch (e) {
      emit(
        TaskUpdatedBlocFailureState(
          loading: state.loading,
          errMsg: e.toString(),
          taskList: state.taskList,
        ),
      );
    }
  }

  TaskBlocState getBlocState({
    bool? loading,
    String? errMsg,
    List<Task>? taskList,
  }) {
    return TaskBlocChangeState(
      loading: loading ?? state.loading,
      errMsg: errMsg ?? state.errMsg,
      taskList: taskList ?? state.taskList,
    );
  }
}

abstract class TaskBlocState {
  final bool loading;
  final String errMsg;
  final List<Task> taskList;

  TaskBlocState({
    required this.loading,
    required this.errMsg,
    required this.taskList,
  });
}

class TaskBlocChangeState extends TaskBlocState {
  TaskBlocChangeState({
    required super.loading,
    required super.errMsg,
    required super.taskList,
  });

  factory TaskBlocChangeState.initial() => TaskBlocChangeState(
        loading: false,
        errMsg: '',
        taskList: [],
      );
}

class TaskCreatedBlocSuccessState extends TaskBlocState {
  TaskCreatedBlocSuccessState({
    required super.loading,
    required super.errMsg,
    required super.taskList,
  });
}

class TaskCreatedBlocFailureState extends TaskBlocState {
  TaskCreatedBlocFailureState({
    required super.loading,
    required super.errMsg,
    required super.taskList,
  });
}

class TaskUpdatedBlocSuccessState extends TaskBlocState {
  TaskUpdatedBlocSuccessState({
    required super.loading,
    required super.errMsg,
    required super.taskList,
  });
}

class TaskUpdatedBlocFailureState extends TaskBlocState {
  TaskUpdatedBlocFailureState({
    required super.loading,
    required super.errMsg,
    required super.taskList,
  });
}

abstract class TaskBlocEvent {}

class GetTasksBlocEvent extends TaskBlocEvent {}

class CreateTaskBlocEvent extends TaskBlocEvent {
  final String taskTitle;
  final String taskDescription;
  CreateTaskBlocEvent({required this.taskTitle, required this.taskDescription});
}

class DeleteTaskBlocEvent extends TaskBlocEvent {
  final int id;
  DeleteTaskBlocEvent({required this.id});
}

class UpdateTaskBlocEvent extends TaskBlocEvent {
  final Task task;
  UpdateTaskBlocEvent({required this.task});
}
