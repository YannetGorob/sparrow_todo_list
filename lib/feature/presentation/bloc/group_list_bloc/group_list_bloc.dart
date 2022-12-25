import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparrow_todo_list/feature/data/models/group/get_groups_model.dart';
import 'package:sparrow_todo_list/feature/domain/repositories/group_repository.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/group_list_bloc/group_list_event.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/group_list_bloc/group_list_state.dart';

class GroupListBloc extends Bloc<GroupEvent, GroupState> {
  final GroupRepository groupRepository;

  GroupListBloc({required this.groupRepository}) : super(GroupEmptyState()) {
    on<GetGroupEvent>((event, emit) async {
      emit(GroupLoadingState());
      try {
        final getGroup = await groupRepository.getGroup();
        print('getGroup');
        emit(GroupLoadedState(groupModel: getGroup, method: 'get'));
      } catch (e) {
        emit(GroupErrorState());
      }
    });

    on<CreateGroupEvent>((event, emit) async {
      emit(GroupLoadingState());
      try {
        GroupModel createdGroups =
            await groupRepository.createGroup(event.groupModel);
        print('createGroup');
        emit(GroupLoadedState<GroupModel>(
            groupModel: createdGroups, method: 'create'));
      } catch (e) {
        emit(GroupErrorState());
      }
    });

    on<UpdateGroupEvent>((event, emit) async {
      emit(GroupLoadingState());
      try {
        final updateGroup =
            await groupRepository.updateGroup(event.id, event.groupModel);
        print('updateGroup');
        emit(GroupLoadedState<GroupModel>(
            groupModel: updateGroup, method: 'update'));
      } catch (e) {
        emit(GroupErrorState());
      }
    });

    on<DeleteGroupEvent>((event, emit) async {
      emit(GroupLoadingState());
      try {
        final deleteGroup = await groupRepository.deleteGroup(event.id);
        print('deleteGroup');
        emit(GroupLoadedState(groupModel: deleteGroup, method: 'delete'));
      } catch (e) {
        emit(GroupErrorState());
      }
    });
  }
}
