part of 'otp_link_bloc.dart';

sealed class OtpLinkEvent extends Equatable {
  const OtpLinkEvent();

  @override
  List<Object> get props => [];
}

final class OTPPinChanged extends OtpLinkEvent {
  const OTPPinChanged(this.pin);
  final String pin;

  @override
  List<Object> get props => [pin];
}

final class PhoneNumberSent extends OtpLinkEvent {
  const PhoneNumberSent(this.phone);
  final String phone;

  @override
  List<Object> get props => [phone];
}

final class PhoneOTPSent extends OtpLinkEvent {
  const PhoneOTPSent({
    required this.verificationId,
    required this.resendToken
  });
  final String verificationId;
  final int? resendToken;
  
  @override
  List<Object> get props => [verificationId, resendToken!];
}

final class OTPVerified extends OtpLinkEvent {
  const OTPVerified({
    required this.smsCode,
    required this.verificationId
  });
  final String smsCode;
  final String verificationId;

  @override
  List<Object> get props => [smsCode, verificationId];
}

final class PhoneAuthVerificationCompleted extends OtpLinkEvent {
  const PhoneAuthVerificationCompleted({required this.authCredential});
  final AuthCredential authCredential;

  @override
  List<Object> get props => [authCredential];
}

final class PhoneAuthFailed extends OtpLinkEvent {
  const PhoneAuthFailed(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}