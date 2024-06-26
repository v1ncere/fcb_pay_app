part of 'otp_verification_bloc.dart';

sealed class OtpVerificationEvent extends Equatable {
  const OtpVerificationEvent();

  @override
  List<Object> get props => [];
}

final class OTPPinChanged extends OtpVerificationEvent {
  const OTPPinChanged(this.pin);
  final String pin;

  @override
  List<Object> get props => [pin];
}

final class PhonNumberSent extends OtpVerificationEvent {
  const PhonNumberSent(this.phoneNumber);
  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

final class PhoneOTPSent extends OtpVerificationEvent {
  const PhoneOTPSent({
    required this.verificationId,
    required this.resendToken,
  });
  final String verificationId;
  final int? resendToken;

  @override
  List<Object> get props => [verificationId, resendToken!];
}

final class OTPVerified extends OtpVerificationEvent {
  const OTPVerified({
    required this.smsCode,
    required this.verificationId
  });
  final String smsCode;
  final String verificationId;

  @override
  List<Object> get props => [smsCode, verificationId];
}

final class PhoneAuthVerificationCompleted extends OtpVerificationEvent {
  const PhoneAuthVerificationCompleted({required this.authCredential});
  final AuthCredential authCredential;

  @override
  List<Object> get props => [authCredential];
}

final class PhoneAuthFailed extends OtpVerificationEvent {
  const PhoneAuthFailed(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}