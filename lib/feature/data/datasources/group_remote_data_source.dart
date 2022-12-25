import 'dart:convert';
import 'package:sparrow_todo_list/common/app_settings.dart';
import 'package:sparrow_todo_list/feature/data/models/group/create_group_model.dart';

import 'package:sparrow_todo_list/feature/data/models/group/get_groups_model.dart';

abstract class GroupRemoteDataSource {
  Future<List<GroupModel>> getGroup();
  Future<GroupModel> createGroup(CreateUpdateGroupModel model);
  Future<GroupModel> updateGroup(int id, CreateUpdateGroupModel model);
  Future deleteGroup(int id);
}

class GroupRemoteDataSourceImpl implements GroupRemoteDataSource {
  @override
  Future<List<GroupModel>> getGroup() async {
    final response = await AppSettings.client.get(
        Uri.parse('${AppSettings.domain}api/Group/GetGroups'),
        headers: {'Authorization': 'Bearer ${AppSettings.token}'});
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      try {
        return (responseJson as List)
            .map((e) => GroupModel.fromJson(e))
            .toList();
      } catch (e) {
        return [];
      }
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<GroupModel> createGroup(CreateUpdateGroupModel model) async {
    final response = await AppSettings.client.post(
      Uri.parse('${AppSettings.domain}api/Group/CreateGroup'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppSettings.token}'
      },
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return GroupModel.fromJson(responseJson);
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<GroupModel> updateGroup(int id, CreateUpdateGroupModel model) async {
    final response = await AppSettings.client.put(
      Uri.parse('${AppSettings.domain}api/Group/UpdateGroup?taskGroupId=$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppSettings.token}'
      },
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return GroupModel.fromJson(responseJson);
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future deleteGroup(int id) async {
    final response = await AppSettings.client.delete(
      Uri.parse('${AppSettings.domain}api/Group/DeleteGroup?taskGroupId=$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppSettings.token}'
      },
    );
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }
}
