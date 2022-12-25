import 'package:sparrow_todo_list/feature/data/datasources/task_remote_data_source.dart';
import 'package:sparrow_todo_list/feature/data/models/task/task_model.dart';
import 'package:sparrow_todo_list/feature/data/models/task/create_update_task.dart';
import 'package:sparrow_todo_list/feature/domain/repositories/task_repository.dart';

class TaskRepositoryImp implements TaskRepository {
  final TaskRemoteDataSource taskRemoteDataSource;

  TaskRepositoryImp({required this.taskRemoteDataSource});

  @override
  Future<TaskModel> changeDoneStatusTask(int id, bool status) async {
    return await taskRemoteDataSource.changeDoneStatusTask(id, status);
  }

  @override
  Future<TaskModel> changePriorityStatusTask(int id, bool status) async {
    return await taskRemoteDataSource.changePriorityStatusTask(id, status);
  }

  @override
  Future<TaskModel> createTask(CreateUpdateTask model) async {
    return await taskRemoteDataSource.createTask(model);
  }

  @override
  Future deleteTask(int id) async {
    return await taskRemoteDataSource.deleteTask(id);
  }

  @override
  Future<List<TaskModel>> getTask(int id) async {
    return await taskRemoteDataSource.getTask(id);
  }

  @override
  Future<TaskModel> updateTask(int id, CreateUpdateTask model) async {
    return await taskRemoteDataSource.updateTask(id, model);
  }
}
