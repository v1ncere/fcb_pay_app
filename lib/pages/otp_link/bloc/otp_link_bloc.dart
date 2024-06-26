import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import '../../../utils/utils.dart';

part 'otp_link_event.dart';
part 'otp_link_state.dart';

class OtpLinkBloc extends Bloc<OtpLinkEvent, OtpLinkState> {
 OtpLinkBloc({
    required FirebaseAuthRepository authRepository,
  }) : _authRepository = authRepository,
  super(const OtpLinkState()) {
    on<OTPPinChanged>(_onOTPPinChanged);
    on<PhoneNumberSent>(_onPhoneNumberSend);
    on<PhoneOTPSent>(_onPhoneOTPSent);
    on<OTPVerified>(_onOTPVerified);
    on<PhoneAuthFailed>(_onPhoneAuthFailed);
    on<PhoneAuthVerificationCompleted>(_onPhoneAuthVerificationCompleted);
  }
  final FirebaseAuthRepository _authRepository;
  
  // SMS PIN handler 
  void _onOTPPinChanged(OTPPinChanged event, Emitter<OtpLinkState> emit) {
    emit(state.copyWith(pin: Pin.dirty(event.pin)));
  }

  // PHONE NUMBER SEND
  Future<void> _onPhoneNumberSend(PhoneNumberSent event, Emitter<OtpLinkState> emit) async {
    try {
      await _authRepository.phoneAuthentication(
        phoneNumber: event.phone,
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
 
  // PHONE OTP SENT
  FutureOr<void> _onPhoneOTPSent(PhoneOTPSent event, Emitter<OtpLinkState> emit) async {
    emit(state.copyWith(verificationId: event.verificationId));
  }

  // OTP VERIFICATION
  void _onOTPVerified(OTPVerified event, Emitter<OtpLinkState> emit) {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
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

  // PHONE AUTHENTICATION COMPLETED
  Future<void> _onPhoneAuthVerificationCompleted(PhoneAuthVerificationCompleted event, Emitter<OtpLinkState> emit) async {
    try {
      final credential = await _authRepository.linkWithCredential(authCredential: event.authCredential);
      if (credential != null) {
        emit(state.copyWith(status: FormzSubmissionStatus.success, message: TextString.otpSuccess));
      }
      
    } on FirebaseAuthenticationFailure catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
    }
  }
  
  // PHONE AUTHENTICATION ERROR
  void _onPhoneAuthFailed(PhoneAuthFailed event, Emitter<OtpLinkState> emit) {
    emit(state.copyWith(status: FormzSubmissionStatus.failure, message: event.message));
  }
}
