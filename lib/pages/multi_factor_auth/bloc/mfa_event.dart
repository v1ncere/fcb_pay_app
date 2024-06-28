part of 'mfa_bloc.dart';

sealed class MfaEvent extends Equatable {
  const MfaEvent();

  @override
  List<Object?> get props => [];
}

final class SmsCodeChange extends MfaEvent {
  const SmsCodeChange(this.pin);
  final String pin;

  @override
  List<Object> get props => [pin];
}

final class MFAPhoneNumberSent extends MfaEvent {
  const MFAPhoneNumberSent(this.phone);
  final String phone;

  @override
  List<Object> get props => [phone];
}

final class MFAPhoneOTPSent extends MfaEvent {
  const MFAPhoneOTPSent({
    required this.verificationId,
    required this.resendToken,
  });
  final String verificationId;
  final int? resendToken;

  @override
  List<Object?> get props => [verificationId, resendToken];
}

final class MFAOTPVerified extends MfaEvent {
  const MFAOTPVerified({
    required this.smsCode,
    required this.verificationId
  });
  final String smsCode;
  final String verificationId;

  @override
  List<Object> get props => [smsCode, verificationId];
}

final class MFAVerificationCompleted extends MfaEvent {
  const MFAVerificationCompleted(this.phoneAuthCredential);
  final PhoneAuthCredential phoneAuthCredential;

  @override
  List<Object> get props => [phoneAuthCredential];
}

final class MFAVerificationFailed extends MfaEvent {
  const MFAVerificationFailed(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}