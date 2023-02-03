import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparrow_todo_list/feature/domain/repositories/account_repository.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/sign_bloc/form_submission_status.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/sign_bloc/login/login_event.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/sign_bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AccountRepository accountRepo;
  LoginBloc(this.accountRepo) : super(LoginState()) {
    //Username updated
    on<LoginUsernameChanged>(
      (event, emit) {
        emit(state.copyWith(
            username: event.username, formStatus: InitialFormStatus()));
      },
    );
    //Password updated
    on<LoginPasswordChanged>(
      (event, emit) {
        emit(state.copyWith(
            password: event.password, formStatus: InitialFormStatus()));
      },
    );

    on<LoginSubmitted>(((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));
      // Form submitted
      try {
        await accountRepo.signIn(event.signInModel);
        emit(state.copyWith(formStatus: SubmitionSucces()));
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e)));
      }
    }));
  }
}
