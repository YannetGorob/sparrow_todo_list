import 'package:sparrow_todo_list/feature/data/models/account/sign_in_model.dart';
import 'package:sparrow_todo_list/feature/data/models/account/sign_up_model.dart';

abstract class SignEvent {}

class UserSignInEvent extends SignEvent {
  SignInModel signInModel;
  UserSignInEvent({required this.signInModel});
}

class UserSignUpEvent extends SignEvent {
  SignUpModel signUpModel;
  UserSignUpEvent({required this.signUpModel});
}
