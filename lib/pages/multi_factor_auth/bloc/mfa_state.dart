part of 'mfa_bloc.dart';

class MfaState extends Equatable with FormzMixin{
  const MfaState({
    this.smsCode = const Pin.pure(),
    this.verificationId = '',
    this.status = FormzSubmissionStatus.initial,
    this.message = ''
  });
  final Pin smsCode;
  final String verificationId;
  final FormzSubmissionStatus status;
  final String message;

  MfaState copyWith({
    Pin? smsCode,
    String? verificationId,
    FormzSubmissionStatus? status,
    String? message
  }) {
    return MfaState(
      smsCode: smsCode ?? this.smsCode,
      verificationId: verificationId ?? this.verificationId,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [smsCode, verificationId, status, message, isValid];
  
  @override
  List<FormzInput> get inputs => [smsCode];
}
