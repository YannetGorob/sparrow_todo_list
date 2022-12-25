import 'package:sparrow_todo_list/feature/data/models/account/user_model.dart';

abstract class UserSignState {}

class UserEmptySignState extends UserSignState {}

class UserLoadingState extends UserSignState {}

class UserLoadedState extends UserSignState {
  UserModel userModel;
  UserLoadedState({required  this.userModel});
}

class UserErrorState extends UserSignState {}
