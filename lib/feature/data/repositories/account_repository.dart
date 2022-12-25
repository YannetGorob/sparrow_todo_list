import 'package:sparrow_todo_list/common/app_settings.dart';
import 'package:sparrow_todo_list/feature/data/datasources/account_remote_data_source.dart';
import 'package:sparrow_todo_list/feature/data/models/account/sign_in_model.dart';
import 'package:sparrow_todo_list/feature/data/models/account/sign_up_model.dart';
import 'package:sparrow_todo_list/feature/data/models/account/user_model.dart';
import 'package:sparrow_todo_list/feature/data/models/account/user_model_and_token.dart';
import 'package:sparrow_todo_list/feature/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource accountRemoteDataSource;

  AccountRepositoryImpl({required this.accountRemoteDataSource});

  @override
  Future<UserModel> getProfile() async {
    return await accountRemoteDataSource.getProfile();
  }

  @override
  Future<UserModel> signIn(SignInModel model) async {
    final response = await accountRemoteDataSource.signIn(model);
    return await sign(response);
  }

  @override
  Future<UserModel> signUp(SignUpModel model) async {
    final response = await accountRemoteDataSource.signUp(model);
    return await sign(response);
  }

  Future<UserModel> sign(UserModelAndToken model) async {
    AppSettings.token = model.token;
    AppSettings.user = model.userModel;
    return model.userModel;
  }
}
