import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'mfa_event.dart';
part 'mfa_state.dart';

class MfaBloc extends Bloc<MfaEvent, MfaState> {
  MfaBloc({
    required FirebaseAuthRepository firebaseAuth
  }) : _authRepository = firebaseAuth,
   super(const MfaState()) {
    on<SmsCodeChange>(_onSmsCodeChange);
    on<MFAPhoneNumberSent>(_onMFAPhoneNumberSent);
    on<MFAPhoneOTPSent>(_onMFAPhoneOTPSent);
    on<MFAOTPVerified>(_onMFAOTPVerified);
    on<MFAVerificationCompleted>(_onMFAVerificationCompleted);
    on<MFAVerificationFailed>(_onMFAVerificationFailed);
  }
  final FirebaseAuthRepository _authRepository;

  void _onSmsCodeChange(SmsCodeChange event, Emitter<MfaState> emit) {
    final smsCode = Pin.dirty(event.pin);
    emit(state.copyWith(smsCode: smsCode));
  }

  Future<void> _onMFAPhoneNumberSent(MFAPhoneNumberSent event, Emitter<MfaState> emit) async {
    try {
      await _authRepository.multiFactorAuthInitiate(
        phoneNumber: event.phone,
        codeSent: (String verificationId, int? resendToken) {
          add(MFAPhoneOTPSent(verificationId: verificationId, resendToken: resendToken));
        },
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
          add(MFAVerificationCompleted(phoneAuthCredential));
        },
        codeAutoRetrievalTimeout: (_) {},
        verificationFailed: (FirebaseAuthException e) {
          add(MFAVerificationFailed(e.toString()));
        },
      );
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
    }
  }

  void _onMFAPhoneOTPSent(MFAPhoneOTPSent event, Emitter<MfaState> emit) {
    emit(state.copyWith(verificationId: event.verificationId));
  }

  FutureOr<void> _onMFAOTPVerified(MFAOTPVerified event, Emitter<MfaState> emit) {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final phoneAuthCredential = _authRepository.createPhoneAuthCredential(
        verificationId: event.verificationId,
        smsCode: event.smsCode
      );
      add(MFAVerificationCompleted(phoneAuthCredential));
    } on FirebaseAuthenticationFailure catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
    }
  }

  FutureOr<void> _onMFAVerificationCompleted(MFAVerificationCompleted event, Emitter<MfaState> emit) async {
    try {
      await _authRepository.multiFactorAuthEnroll(phoneAuthCredential: event.phoneAuthCredential);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on FirebaseAuthenticationFailure catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
    }
  }

  void _onMFAVerificationFailed(MFAVerificationFailed event, Emitter<MfaState> emit) {
    emit(state.copyWith(status: FormzSubmissionStatus.failure, message: event.message));
  }
}
