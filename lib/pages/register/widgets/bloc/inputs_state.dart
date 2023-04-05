part of 'inputs_bloc.dart';

class InputsState extends Equatable with FormzMixin {
  const InputsState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.accountNumber = const AccountNumber.pure(),
    this.mobileNumber = const MobileNumber.pure(),
    this.status = FormzSubmissionStatus.initial,
  });
  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final AccountNumber accountNumber;
  final MobileNumber mobileNumber;
  final FormzSubmissionStatus status;
  
  InputsState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    AccountNumber? accountNumber,
    MobileNumber? mobileNumber,
    FormzSubmissionStatus? status,
  }) {
    return InputsState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      accountNumber: accountNumber ?? this.accountNumber,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
    email,
    password,
    confirmedPassword,
    accountNumber,
    mobileNumber,
    status,
    isValid,
    isPure,
  ];
  
  @override
  List<FormzInput> get inputs => [
    email,
    password,
    confirmedPassword,
    accountNumber,
    mobileNumber
  ];
}