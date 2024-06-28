import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'update_password_event.dart';
part 'update_password_state.dart';

class UpdatePasswordBloc extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  UpdatePasswordBloc() : super(const UpdatePasswordState()) {
    on<UpdateNewPasswordChanged>(_onUpdateNewPasswordChanged);
    on<UpdateConfirmNewPasswordChanged>(_onUpdateConfirmNewPasswordChanged);
    on<UpdatePasswordObscured>(_onUpdatePasswordObscured);
    on<UpdateNewPasswordObscured>(_onUpdateNewPasswordObscured);
    on<UpdateConfirmNewPasswordObscured>(_onUpdateConfirmNewPasswordObscured);
    on<PasswordUpdateSubmitted>(_onPasswordUpdateSubmitted);
  }

  void _onUpdateNewPasswordChanged(UpdateNewPasswordChanged event, Emitter<UpdatePasswordState> emit) {
    final newPassword = Password.dirty(event.newPassword);
    emit(state.copyWith(newPassword: newPassword));
  }

  void _onUpdateConfirmNewPasswordChanged(UpdateConfirmNewPasswordChanged event, Emitter<UpdatePasswordState> emit) {
    final confirmPassword = ConfirmedPassword.dirty(password: state.newPassword.value, value: event.confirmPassword);
    emit(state.copyWith(confirmNewPassword: confirmPassword));
  }

  void _onUpdatePasswordObscured(UpdatePasswordObscured event, Emitter<UpdatePasswordState> emit) {
    emit(state.copyWith(isPasswordObscure: !state.isPasswordObscure));
  }

  void _onUpdateNewPasswordObscured(UpdateNewPasswordObscured event, Emitter<UpdatePasswordState> emit) {
    emit(state.copyWith(isNewPasswordObscure: !state.isNewPasswordObscure));
  }

  void _onUpdateConfirmNewPasswordObscured(UpdateConfirmNewPasswordObscured event, Emitter<UpdatePasswordState> emit) {
    emit(state.copyWith(isConfirmNewPasswordObscure: !state.isConfirmNewPasswordObscure));
  }

  FutureOr<void> _onPasswordUpdateSubmitted(PasswordUpdateSubmitted event, Emitter<UpdatePasswordState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await FirebaseAuth.instance.currentUser?.updatePassword(state.newPassword.value);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } on FirebaseAuthException catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.code));
      } catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: "Error: ${e.toString().replaceAll('Exception: ', "")}"));
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

