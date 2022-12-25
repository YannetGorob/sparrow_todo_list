import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparrow_todo_list/feature/domain/repositories/account_repository.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/sign_bloc/sign_event.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/sign_bloc/sign_state.dart';

class SignBloc extends Bloc<SignEvent, UserSignState> {
  final AccountRepository accountRepository;
  SignBloc({required this.accountRepository}) : super(UserEmptySignState()) {
    on<UserSignInEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final loadedUser = await accountRepository.signIn(event.signInModel);
        emit(UserLoadedState(userModel: loadedUser));
      } catch (e) {
        emit(UserErrorState());
      }
    });

    on<UserSignUpEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final loadedUser = await accountRepository.signUp(event.signUpModel);
        emit(UserLoadedState(userModel: loadedUser));
      } catch (e) {
        emit(UserErrorState());
      }
    });
  }
}
