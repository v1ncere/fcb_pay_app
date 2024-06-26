import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import '../../../utils/utils.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required FirebaseAuthRepository firebaseAuth,
  }) : _firebaseAuth = firebaseAuth,
  super(const LoginState()) {
    on<LoginEmailChanged>(_onLoginEmailChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<MobileNumberInputChanged>(_onMobileNumberInputChanged);
    on<OtpInputChanged>(_onOTPInputChanged);
    on<LoginPasswordObscured>(_onLoginPasswordObscured);
    on<LoggedInWithCredentials>(_onLoggedInWithCredentials);
    on<LoginOptionChanged>(_onLoginOptionChanged);
    on<PhoneNumberSent>(_onPhoneNumberSent);
    on<TimerCountedDownChanged>(_onTimerCountedDownChanged);
    on<CodeSent>(_onCodeSent);
    on<PhoneNumberResent>(_onPhoneNumberResent);
    on<OtpVerified>(_onOtpVerified);
    on<PhoneAuthenticationCompleted>(_onPhoneAuthenticationCompleted);
    on<PhoneVerificationFailed>(_onPhoneVerificationFailed);
  }
  final FirebaseAuthRepository _firebaseAuth;
  Timer? _timer;

  void _onLoginEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: Email.dirty(event.email)));
  }

  void _onLoginPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: Password.dirty(event.password)));
  }

  void _onMobileNumberInputChanged(MobileNumberInputChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(mobile: MobileNumber.dirty(event.mobile)));
  }

  void _onLoginPasswordObscured(LoginPasswordObscured event, Emitter<LoginState> emit) {
    emit(state.copyWith(isObscure: !state.isObscure));
  }

  void _onOTPInputChanged(OtpInputChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(otp: Pin.dirty(event.otp)));
  }

  void _onLoginOptionChanged(LoginOptionChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(loginOption: event.option, otpEnabled: false, isGetOtpTapped: false));
  }

  // PHONE NUMBER SENT
  Future<void> _onPhoneNumberSent(PhoneNumberSent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress, isGetOtpTapped: true));
    await _firebaseAuth.phoneAuthentication(
      phoneNumber: event.phoneNumber,
      codeSent: (String verificationId, int? resendToken) async {
        add(CodeSent(verificationId: verificationId, resendToken: resendToken));
        startTimer(90);
      },
      codeAutoRetrievalTimeout: (_) {},
      verificationCompleted: (_) {},
      verificationFailed: (FirebaseAuthException e) => add(PhoneVerificationFailed(e.message!)),
      timeout: const Duration(seconds: 90)
    );
  }

  // OTP PHONE NUMBER RESENT
  Future<void> _onPhoneNumberResent(PhoneNumberResent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    await _firebaseAuth.phoneAuthentication(
      phoneNumber: event.phoneNumber,
      forceResendingToken: state.resendToken,
      codeSent: (String verificationId, int? resendToken) async {
        add(CodeSent(verificationId: verificationId, resendToken: resendToken)); 
        startTimer(60);
      },
      codeAutoRetrievalTimeout: (_){},
      verificationCompleted: (_){},
      verificationFailed: (FirebaseAuthException e) => add(PhoneVerificationFailed(e.message!)),
      timeout: const Duration(seconds: 60),
    );
  }

  startTimer(int max) {
    _timer?.cancel();
    int currentSeconds = max;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      add(TimerCountedDownChanged((currentSeconds--).toString().padLeft(2, '0')));
      if(currentSeconds == 0) {
        timer.cancel();
        add(const PhoneVerificationFailed(TextString.otpExpired));
      }
    });
  }

  // OTP CODE SENT TRIGGERED
  Future<void> _onCodeSent(CodeSent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
      status: FormzSubmissionStatus.canceled, 
      verificationId: event.verificationId, 
      resendToken: event.resendToken, 
      otpEnabled: true
    ));
  }

  // USER PRESS VERIFY
  Future<void> _onOtpVerified(OtpVerified event, Emitter<LoginState> emit) async {
    if (state.mobile.isValid && state.otp.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final authCredential = _firebaseAuth.createPhoneAuthCredential(verificationId: event.verificationId, smsCode: event.smsCode);
      add(PhoneAuthenticationCompleted(authCredential));
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.formError));
    }
  }

  // OTP VERIFICATION PROCESS COMPLETED
  Future<void> _onPhoneAuthenticationCompleted(PhoneAuthenticationCompleted event, Emitter<LoginState> emit) async {
    try {
      final credential =  await _firebaseAuth.signInWithAuthCredential(authCredential: event.authCredential);
      // use this for more secure login
      // final isApproved = (await customClaims)!['approved'] == true;
      if (credential != null) {
        if (credential.user!.email != null) {
          if(credential.user!.emailVerified != true) {
            emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.verifyEmail));
          } else {
            emit(state.copyWith(status: FormzSubmissionStatus.success));
          }
        } else {
          emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.noEmail));
          // delete user created from signing-in using phone number in phone authentication
          // firebase will auto create user if not yet created in authentication
          await credential.user?.delete();
        }
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: 'Authentication failed'));
      }
    } on FirebaseAuthenticationFailure catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
    }
  }
  
  // OTP FAILURE
  void _onPhoneVerificationFailed(PhoneVerificationFailed event, Emitter<LoginState> emit) {
    emit(state.copyWith(status: FormzSubmissionStatus.failure, message: event.message, otpEnabled: false));
  }

  FutureOr<void> _onLoggedInWithCredentials(LoggedInWithCredentials event, Emitter<LoginState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _firebaseAuth.logInWithEmailAndPassword(email: state.email.value, password: state.password.value).then((credential) {
          // use this for more secure login
          // final isApproved = (await customClaims)!['approved'] == true;
          if(credential != null && credential.user!.emailVerified != true) {
            emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.verifyEmail));
          } else {
            emit(state.copyWith(status: FormzSubmissionStatus.success));
          }
        });
      } on FirebaseAuthenticationFailure catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
      } catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString().replaceAll('Exception: ', '')  ));
      }
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.formError));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  void _onTimerCountedDownChanged(TimerCountedDownChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(timerDisplay: event.timer));
  }
  
  Future<Map<dynamic, dynamic>?> get customClaims async {
    final user = FirebaseAuth.instance.currentUser;
    final token = await user?.getIdTokenResult(true);
    return token?.claims;
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    return super.close();
  }
}
