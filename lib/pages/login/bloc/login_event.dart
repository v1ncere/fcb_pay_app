part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

final class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

final class MobileNumberInputChanged extends LoginEvent {
  const MobileNumberInputChanged(this.mobile);
  final String mobile;

  @override
  List<Object> get props => [mobile];
}

final class OtpInputChanged extends LoginEvent {
  const OtpInputChanged(this.otp);
  final String otp;

  @override
  List<Object> get props => [otp];
}

final class LoginOptionChanged extends LoginEvent {
  const LoginOptionChanged(this.option);
  final LoginOption option;

  @override
  List<Object> get props => [option];
}

final class LoginPasswordObscured extends LoginEvent {}

final class LoggedInWithCredentials extends LoginEvent {}

final class PhoneNumberSent extends LoginEvent {
  const PhoneNumberSent(this.phoneNumber);
  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

final class PhoneNumberResent extends LoginEvent {
  const PhoneNumberResent(this.phoneNumber);
  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

final class CodeSent extends LoginEvent {
  const CodeSent({
    required this.verificationId,
    required this.resendToken
  });
  final String verificationId;
  final int? resendToken;

  @override
  List<Object> get props => [verificationId, resendToken!];
}

final class OtpVerified extends LoginEvent {
  const OtpVerified({
    required this.smsCode,
    required this.verificationId
  });
  final String smsCode;
  final String verificationId;

  @override
  List<Object> get props => [smsCode, verificationId];
}

final class PhoneAuthenticationCompleted extends LoginEvent {
  const PhoneAuthenticationCompleted(this.authCredential);
  final AuthCredential authCredential;

  @override
  List<Object> get props => [authCredential];
}

final class PhoneVerificationFailed extends LoginEvent {
  const PhoneVerificationFailed(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

final class TimerCountedDownChanged extends LoginEvent {
  const TimerCountedDownChanged(this.timer);
  final String timer;

  @override
  List<Object> get props => [timer];
}