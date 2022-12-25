import 'package:sparrow_todo_list/feature/data/models/account/sign_in_model.dart';
import 'package:sparrow_todo_list/feature/data/models/account/sign_up_model.dart';
import 'package:sparrow_todo_list/feature/data/models/account/user_model.dart';

abstract class AccountRepository {
  Future<UserModel> getProfile();
  Future<UserModel> signIn(SignInModel model);
  Future<UserModel> signUp(SignUpModel model);
}


