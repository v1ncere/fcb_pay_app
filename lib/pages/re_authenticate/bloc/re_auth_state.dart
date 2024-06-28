part of 're_auth_bloc.dart';

class ReAuthState extends Equatable with FormzMixin {
  const ReAuthState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isObscure = true,
    this.status = FormzSubmissionStatus.initial,
    this.message = ''
  });
  final Email email;
  final Password password;
  final bool isObscure;
  final FormzSubmissionStatus status;
  final String message;

  ReAuthState copyWith({
    Email? email,
    Password? password,
    bool? isObscure,
    FormzSubmissionStatus? status,
    String? message,
  }) {
    return ReAuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      isObscure: isObscure ?? this.isObscure,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
  
  @override
  List<Object> get props => [ email, password, isObscure, status, message, isValid ];
  
  @override
  List<FormzInput> get inputs => [ email, password ];
}
