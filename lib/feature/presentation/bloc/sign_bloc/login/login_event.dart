import 'package:sparrow_todo_list/feature/data/models/account/sign_in_model.dart';

abstract class LoginEvent {}

class LoginUsernameChanged extends LoginEvent {
  final String username;

  LoginUsernameChanged(this.username);
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged(this.password);
}

class LoginSubmitted extends LoginEvent {
  SignInModel signInModel;
  LoginSubmitted(this.signInModel);
}
