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
  })  : _firebaseAuthService = firebaseAuthService,
        super(const LoginState()) {

    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: Email.dirty(event.email)));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: Password.dirty(event.password)));
    });

    on<LoggedInWithCredentials>((event, emit) async {
      if (state.isValid) {
        emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
        try {
          await _firebaseAuthService.logInWithEmailAndPassword(
            email: state.email.value,
            password: state.password.value
          ).then((credential) {
            if(credential?.user?.emailVerified != true) {
              emit(state.copyWith(
                message: "Please verify your email address to continue. We've sent a verification link to your email.",
                status: FormzSubmissionStatus.failure
              ));
            } else {
              emit(state.copyWith(status: FormzSubmissionStatus.success));
            }
          });
        } on LogInWithEmailAndPasswordFailure catch (e) {
          emit(state.copyWith(
            message: e.message,
            status: FormzSubmissionStatus.failure
          ));
        } catch (e) {
          emit(state.copyWith(
            message: e.toString(),
            status: FormzSubmissionStatus.failure
          ));
        }
      }
    });
  }
  final FirebaseAuthRepository _firebaseAuthService;
}
