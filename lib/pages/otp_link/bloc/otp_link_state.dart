part of 'otp_link_bloc.dart';

class OtpLinkState extends Equatable with FormzMixin {
  const OtpLinkState({
    this.pin = const Pin.pure(),
    this.verificationId = '',
    this.status = FormzSubmissionStatus.initial,
    this.message = ''
  });
  final Pin pin;
  final String verificationId;
  final FormzSubmissionStatus status;
  final String message;

  OtpLinkState copyWith({
    Pin? pin,
    String? verificationId,
    FormzSubmissionStatus? status,
    String? message
  }) {
    return OtpLinkState(
      pin: pin ?? this.pin,
      verificationId: verificationId ?? this.verificationId,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [pin, verificationId, status, message];
  
  @override
  List<FormzInput> get inputs => [pin];
}