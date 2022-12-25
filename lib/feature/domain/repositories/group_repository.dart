
import 'package:sparrow_todo_list/feature/data/models/group/create_group_model.dart';
import 'package:sparrow_todo_list/feature/data/models/group/get_groups_model.dart';

abstract class GroupRepository {
  Future<List<GroupModel>> getGroup();
  Future<GroupModel> createGroup(CreateUpdateGroupModel model);
  Future<GroupModel> updateGroup(int id, CreateUpdateGroupModel model);
  Future deleteGroup(int id);
}
