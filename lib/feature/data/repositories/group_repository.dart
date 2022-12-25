import 'package:sparrow_todo_list/feature/data/datasources/group_remote_data_source.dart';
import 'package:sparrow_todo_list/feature/data/models/group/create_group_model.dart';
import 'package:sparrow_todo_list/feature/data/models/group/get_groups_model.dart';

import 'package:sparrow_todo_list/feature/domain/repositories/group_repository.dart';

class GroupRepositoryImp implements GroupRepository {
  final GroupRemoteDataSource groupRemoteDataSource;

  GroupRepositoryImp({ required this.groupRemoteDataSource});

  @override
  Future<GroupModel> createGroup(CreateUpdateGroupModel model) async {
    return await groupRemoteDataSource.createGroup(model);
  }

  @override
  Future deleteGroup(int id) async {
    return await groupRemoteDataSource.deleteGroup(id);
  }

  @override
  Future<List<GroupModel>> getGroup() async {
    return await groupRemoteDataSource.getGroup();
  }

  @override
  Future<GroupModel> updateGroup(int id, CreateUpdateGroupModel model) async {
    return await groupRemoteDataSource.updateGroup(id, model);
  }
}
