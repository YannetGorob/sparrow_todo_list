import 'dart:convert';
import 'package:sparrow_todo_list/common/app_settings.dart';
import 'package:sparrow_todo_list/feature/data/models/task/create_update_task.dart';
import 'package:sparrow_todo_list/feature/data/models/task/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getTask(int id);
  Future<TaskModel> createTask(CreateUpdateTask model);
  Future<TaskModel> updateTask(int id, CreateUpdateTask model);
  Future<TaskModel> changeDoneStatusTask(int id, bool status);
  Future<TaskModel> changePriorityStatusTask(int id, bool status);
  Future deleteTask(int id);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  @override
  Future<List<TaskModel>> getTask(int id) async {
    final response = await AppSettings.client.get(
        Uri.parse('${AppSettings.domain}api/Task/GetTasks?taskGroupId=$id'),
        headers: {'Authorization': 'Bearer ${AppSettings.token}'});
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return (responseJson as List).map((e) => TaskModel.fromJson(e)).toList();
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<TaskModel> createTask(CreateUpdateTask model) async {
    final response = await AppSettings.client.post(
      Uri.parse('${AppSettings.domain}api/Task/CreateTask'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppSettings.token}'
      },
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return TaskModel.fromJson(responseJson);
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<TaskModel> updateTask(int id, CreateUpdateTask model) async {
    final response = await AppSettings.client.put(
      Uri.parse('${AppSettings.domain}api/Task/UpdateTask?taskId=$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppSettings.token}'
      },
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return TaskModel.fromJson(responseJson);
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<TaskModel> changeDoneStatusTask(int id, bool status) async {
    final response = await AppSettings.client.put(
        Uri.parse(
            '${AppSettings.domain}api/Task/ChangeDoneStatusTask?taskGroupId=$id&status=$status'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppSettings.token}'
        });
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print('done toggle');
      return TaskModel.fromJson(responseJson);
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<TaskModel> changePriorityStatusTask(int id, bool status) async {
    final response = await AppSettings.client.put(
        Uri.parse(
            '${AppSettings.domain}api/Task/ChangePriorityStatusTask?taskGroupId=$id&status=$status'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppSettings.token}'
        });
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return TaskModel.fromJson(responseJson);
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future deleteTask(int id) async {
    final response = await AppSettings.client.delete(
        Uri.parse('${AppSettings.domain}api/Task/DeleteTask?taskGroupId=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppSettings.token}'
        });
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }
}
