import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 're_auth_event.dart';
part 're_auth_state.dart';

class ReAuthBloc extends Bloc<ReAuthEvent, ReAuthState> {
  ReAuthBloc({
    required FirebaseAuthRepository firebaseAuth,
  }) : _authRepository = firebaseAuth,
  super(const ReAuthState()) {
    on<ReAuthEmailChanged>(_onReAuthEmailChanged);
    on<ReAuthPasswordChanged>(_onReAuthPasswordChanged);
    on<ReAuthPasswordObscured>(_onReAuthPasswordObscured);
    on<ReAuthenticatedWithCredentials>(_onReAuthenticatedWithCredentials);
  }
  final FirebaseAuthRepository _authRepository;

  void _onReAuthEmailChanged(ReAuthEmailChanged event, Emitter<ReAuthState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(email: email));
  }

  void _onReAuthPasswordChanged(ReAuthPasswordChanged event, Emitter<ReAuthState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(password: password));
  }

  void _onReAuthPasswordObscured(ReAuthPasswordObscured event, Emitter<ReAuthState> emit) {
    emit(state.copyWith(isObscure: !state.isObscure));
  }

  FutureOr<void> _onReAuthenticatedWithCredentials(ReAuthenticatedWithCredentials event, Emitter<ReAuthState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        final cred = await _authRepository.reauthenticateUserWithCredential(
          email: state.email.value,
          password: state.password.value
        );
        if (cred != null) {
          emit(state.copyWith(
            status: FormzSubmissionStatus.success, 
            message: 'Reauthentication successful. You can now proceed with your requested action.'
          ));
        } else {
          emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            message: 'Reauthentication failed.'
          ));
        }
      } on FirebaseAuthenticationFailure catch (e) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          message: e.message
        ));
      } catch (e) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          message: e.toString().replaceAll('Exception: ', '')
        ));
      }
    } else {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        message: 'Please complete all required fields before submitting your form. Thank you!'
      ));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }
}
