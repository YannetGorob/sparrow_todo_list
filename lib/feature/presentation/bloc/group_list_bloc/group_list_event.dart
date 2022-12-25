import 'package:sparrow_todo_list/feature/data/models/group/create_group_model.dart';


abstract class GroupEvent {}

class GetGroupEvent extends GroupEvent {}

class CreateGroupEvent extends GroupEvent {
  CreateUpdateGroupModel groupModel;
  CreateGroupEvent({required this.groupModel});
}

class UpdateGroupEvent extends GroupEvent {
  CreateUpdateGroupModel groupModel;
  int id;
  UpdateGroupEvent({required this.groupModel, required this.id});
}

class DeleteGroupEvent extends GroupEvent {
  int id;
  DeleteGroupEvent({required this.id});
}
