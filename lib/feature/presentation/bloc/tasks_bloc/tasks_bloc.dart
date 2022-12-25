import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparrow_todo_list/feature/data/models/task/task_model.dart';
import 'package:sparrow_todo_list/feature/domain/repositories/task_repository.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/tasks_bloc/tasks_event.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/tasks_bloc/tasks_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc({required this.taskRepository}) : super(TaskEmptyState()) {
    on<GetTaskEvent>((event, emit) async {
      emit(TaskLoadingState());
      try {
        print('run get task');
        final getTask = await taskRepository.getTask(event.id);
        print('getTask');
        emit(TaskLoadedState(taskmodel: getTask, method: 'get'));
      } catch (e) {
        emit(TaskErrorState());
      }
    });

    on<CreateTaskEvent>((event, emit) async {
      emit(TaskLoadingState());
      try {
        TaskModel createdTasks =
            await taskRepository.createTask(event.taskmodel);
        print('create Task');
        emit(TaskLoadedState<TaskModel>(
            taskmodel: createdTasks, method: 'create'));
      } catch (e) {
        emit(TaskErrorState());
      }
    });

    on<ChangeDoneStatusTaskEvent>((event, emit) async {
      emit(TaskLoadingState());
      try {
        print('run change status task');
        final changedStatusTask =
            await taskRepository.changeDoneStatusTask(event.id, event.status);
        print('change status task');
        emit(TaskLoadedState(
            taskmodel: changedStatusTask, method: 'changeStatus'));
      } catch (e) {
        emit(TaskErrorState());
      }
    });

    on<ChangePriorityStatusTask>((event, emit) async {
      emit(TaskLoadingState());
      try {
        print('run change priority status task');
        final changedStatusTask =
            await taskRepository.changePriorityStatusTask(event.id, event.status);
        print('change  priority status task');
        emit(TaskLoadedState(
            taskmodel: changedStatusTask, method: 'changePriorityStatus'));
      } catch (e) {
        emit(TaskErrorState());
      }
    });

    on<UpdateTaskEvent>((event, emit) async {
      emit(TaskLoadingState());
      try {
        final updateTask =
            await taskRepository.updateTask(event.id, event.taskmodel);
        print('update Task');
        emit(TaskLoadedState<TaskModel>(
            taskmodel: updateTask, method: 'update'));
      } catch (e) {
        emit(TaskErrorState());
      }
    });

    on<DeleteTaskEvent>((event, emit) async {
      emit(TaskLoadingState());
      try {
        final deleteTask = await taskRepository.deleteTask(event.id);
        print('delete Task');
        emit(TaskLoadedState(taskmodel: deleteTask, method: 'delete'));
      } catch (e) {
        emit(TaskErrorState());
      }
    });
  }
}
