abstract class TaskState {}

class TaskEmptyState extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskLoadedState<T> extends TaskState {
  T taskmodel;
  String method;
  TaskLoadedState({required this.taskmodel, required this.method});
}

class TaskErrorState extends TaskState {}
