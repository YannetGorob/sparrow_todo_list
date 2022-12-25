abstract class GroupState {}

class GroupEmptyState extends GroupState {}

class GroupLoadingState extends GroupState {}

class GroupLoadedState<T> extends GroupState {
  T groupModel;
  String method;
  GroupLoadedState({required this.groupModel, required this.method});
}

class GroupErrorState extends GroupState {}
