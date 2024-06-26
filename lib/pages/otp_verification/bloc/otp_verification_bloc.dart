import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import '../../../utils/utils.dart'; 

part 'otp_verification_event.dart';
part 'otp_verification_state.dart';

class OtpVerificationBloc extends Bloc<OtpVerificationEvent, OtpVerificationState> {
 OtpVerificationBloc({
    required FirebaseAuthRepository authRepository,
  }) : _authRepository = authRepository,
  super(const OtpVerificationState()) {
    on<OTPPinChanged>(_onOTPPinChanged);
    on<PhonNumberSent>(_onPhoneNumberSend);
    on<PhoneOTPSent>(_onPhoneOTPSent);
    on<OTPVerified>(_onOTPVerified);
    on<PhoneAuthFailed>(_onPhoneAuthFailed);
    on<PhoneAuthVerificationCompleted>(_onPhoneAuthVerificationCompleted);
  }
  final FirebaseAuthRepository _authRepository;

  void _onOTPPinChanged(OTPPinChanged event, Emitter<OtpVerificationState> emit) {
    final pin = Pin.dirty(event.pin);
    emit(state.copyWith(pin: pin));
  }

    // PHONE NUMBER SEND
  Future<void> _onPhoneNumberSend(PhonNumberSent event, Emitter<OtpVerificationState> emit) async {
    try {
      await _authRepository.phoneAuthentication(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential authCredential) {
          add(PhoneAuthVerificationCompleted(authCredential: authCredential));
        },
        codeSent: (String verificationId, int? resendToken) async {
          add(PhoneOTPSent(verificationId: verificationId, resendToken: resendToken));
        },
        verificationFailed: (FirebaseAuthException e) {
          add(PhoneAuthFailed(e.toString()));
        },
        codeAutoRetrievalTimeout: (_) {},
      );
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
    }
  }

  Future<void> _onPhoneOTPSent(PhoneOTPSent event, Emitter<OtpVerificationState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.success, verificationId: event.verificationId));
  }

  FutureOr<void> _onOTPVerified(OTPVerified event, Emitter<OtpVerificationState> emit) {
    try {
      final authCredential = _authRepository.createPhoneAuthCredential(
        verificationId: event.verificationId,
        smsCode: event.smsCode
      );
      add(PhoneAuthVerificationCompleted(authCredential: authCredential));
    } on FirebaseAuthenticationFailure catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
    }
  }

  FutureOr<void> _onPhoneAuthVerificationCompleted(PhoneAuthVerificationCompleted event, Emitter<OtpVerificationState> emit) async {
    try {
      final auth = await _authRepository.signInWithAuthCredential(authCredential: event.authCredential);
      if (auth != null) {
        emit(state.copyWith(status: FormzSubmissionStatus.success, message: TextString.otpSuccess));
      }
    } on FirebaseAuthenticationFailure catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
    }
  }

  FutureOr<void> _onPhoneAuthFailed(PhoneAuthFailed event, Emitter<OtpVerificationState> emit) {
    emit(state.copyWith(status: FormzSubmissionStatus.failure, message: event.message));
  }
}
