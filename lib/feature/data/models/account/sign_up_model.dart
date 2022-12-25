import 'package:sparrow_todo_list/feature/data/models/account/sign_model.dart';

class SignUpModel implements SignModel {
  final String name; //1
  final String surname; //1
  final String email;  //2
  final String login; //2
  final String phone; //2
  final String password; //1

  SignUpModel(
      {required this.name,
      required this.surname,
      required this.email,
      required this.login,
      required this.phone,
      required this.password});

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      name: json['name'] as String,
      surname: json['surname'] as String,
      email: json['email'] as String,
      login: json['login'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'email': email,
      'login': login,
      'phone': phone,
      'password': password,
    };
  }
}
