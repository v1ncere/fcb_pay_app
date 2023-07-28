part of 'register_bloc.dart';

class RegisterState extends Equatable with FormzMixin {
  const RegisterState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.mobileNumber = const MobileNumber.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.error = ""
  });
  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final MobileNumber mobileNumber;
  final FormzSubmissionStatus status;
  final String error;

  RegisterState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    AccountNumber? accountNumber,
    MobileNumber? mobileNumber,
    FormzSubmissionStatus? status,
    String? error
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      status: status ?? this.status,
      error: error ?? this.error
    );
  }
  
  @override
  List<Object> get props => [
    email,
    password,
    confirmedPassword,
    mobileNumber,
    status,
    error,
    isValid,
    isPure
  ];

  @override
  List<FormzInput> get inputs => [
    email,
    password,
    confirmedPassword,
    mobileNumber
  ];
}
