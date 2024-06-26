part of 'otp_verification_bloc.dart';

class OtpVerificationState extends Equatable with FormzMixin {
  const OtpVerificationState({
    this.pin = const Pin.pure(),
    this.verificationId = '',
    this.status = FormzSubmissionStatus.initial,
    this.message = ''
  });
  final Pin pin;
  final String verificationId;
  final FormzSubmissionStatus status;
  final String message;

  OtpVerificationState copyWith({
    Pin? pin,
    String? verificationId,
    FormzSubmissionStatus? status,
    String? message
  }) {
    return OtpVerificationState(
      pin: pin ?? this.pin,
      verificationId: verificationId ?? this.verificationId,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [pin, verificationId, status, message, isValid];
  
  @override
  List<FormzInput> get inputs => [pin];
}