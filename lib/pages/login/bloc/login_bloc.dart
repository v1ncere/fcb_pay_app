import 'package:equatable/equatable.dart';
import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required FirebaseAuthRepository firebaseAuthService
  }): _firebaseAuthService = firebaseAuthService,
      super(const LoginState()) {
        on<LoginEmailChanged>(_onLoginEmailChanged);
        on<LoginPasswordChanged>(_onLoginPasswordChanged);
        on<LoggedInWithCredentials>(_onLoggedInWithCredentials);
      }
  final FirebaseAuthRepository _firebaseAuthService;
  
  void _onLoginEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(email: email));
  }

  void _onLoginPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(password: password));
  }

  Future<void> _onLoggedInWithCredentials(LoggedInWithCredentials event, Emitter<LoginState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _firebaseAuthService.logInWithEmailAndPassword(
          email: state.email.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } on LogInWithEmailAndPasswordFailure catch (e) {
        emit(state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ));
      } catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
