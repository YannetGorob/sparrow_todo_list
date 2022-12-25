import 'package:sparrow_todo_list/feature/data/models/task/create_update_task.dart';

abstract class TaskEvent {}

class GetTaskEvent extends TaskEvent {
  int id;
  GetTaskEvent({required this.id});
}

class CreateTaskEvent extends TaskEvent {
  CreateUpdateTask taskmodel;
  CreateTaskEvent({required this.taskmodel});
}

class UpdateTaskEvent extends TaskEvent {
  CreateUpdateTask taskmodel;
  int id;

  UpdateTaskEvent({required this.taskmodel, required this.id});
}

class ChangeDoneStatusTaskEvent extends TaskEvent {
  int id;
  bool status;
  ChangeDoneStatusTaskEvent({required this.id, required this.status});
}

class ChangePriorityStatusTask extends TaskEvent {
  int id;
  bool status;
  ChangePriorityStatusTask({required this.id, required this.status});
}

class DeleteTaskEvent extends TaskEvent {
  int id;
  DeleteTaskEvent({required this.id});
}
