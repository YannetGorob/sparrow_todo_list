import 'package:sparrow_todo_list/feature/data/models/task/create_update_task.dart';
import 'package:sparrow_todo_list/feature/data/models/task/task_model.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getTask(int id);
  Future<TaskModel> createTask(CreateUpdateTask model);
  Future<TaskModel> updateTask(int id, CreateUpdateTask model);
  Future<TaskModel> changeDoneStatusTask(int id, bool status);
  Future<TaskModel> changePriorityStatusTask(int id, bool status);
  Future deleteTask(int id);
}
