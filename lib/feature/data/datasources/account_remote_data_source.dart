import 'dart:convert';

import 'package:sparrow_todo_list/common/app_settings.dart';
import 'package:sparrow_todo_list/feature/data/models/account/sign_in_model.dart';
import 'package:sparrow_todo_list/feature/data/models/account/sign_model.dart';
import 'package:sparrow_todo_list/feature/data/models/account/sign_up_model.dart';
import 'package:sparrow_todo_list/feature/data/models/account/user_model.dart';
import 'package:sparrow_todo_list/feature/data/models/account/user_model_and_token.dart';

abstract class AccountRemoteDataSource {
  Future<UserModelAndToken> signIn(SignInModel model);
  Future<UserModelAndToken> signUp(SignUpModel model);
  Future<UserModel> getProfile();
}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  @override
  Future<UserModel> getProfile() async {
    final response = await AppSettings.client.get(
        Uri.parse('${AppSettings.domain}api/Account/GetProfile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppSettings.token}'
        });
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return UserModel.fromJson(responseJson);
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<UserModelAndToken> signIn(SignInModel model) async {
    return await sign(
        model, Uri.parse('${AppSettings.domain}api/Account/SignIn'));
  }

  @override
  Future<UserModelAndToken> signUp(SignUpModel model) async {
    return await sign(
        model, Uri.parse('${AppSettings.domain}api/Account/SignUp'));
  }

  Future<UserModelAndToken> sign(SignModel model, Uri path) async {
    final response = await AppSettings.client.post(path,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(model.toJson()));
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      final user = UserModel.fromJson(responseJson['user']);
      final token = responseJson['token'].toString();
      return UserModelAndToken(userModel: user, token: token);
    } else {
      throw Exception(response.body);
    }
  }
}
