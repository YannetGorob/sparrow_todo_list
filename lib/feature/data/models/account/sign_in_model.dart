import 'package:sparrow_todo_list/feature/data/models/account/sign_model.dart';

class SignInModel implements SignModel {
  final String login;
  final String password;
  const SignInModel({required this.login, required this.password});

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      login: json['login'] as String,
      password: json['password'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'password': password,
    };
  }
}
