part of 'inputs_bloc.dart';

class InputsState extends Equatable {
  const InputsState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.accountNumber = const AccountNumber.pure(),
    this.mobileNumber = const MobileNumber.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final AccountNumber accountNumber;
  final MobileNumber mobileNumber;
  final FormzStatus status;
  
  InputsState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    AccountNumber? accountNumber,
    MobileNumber? mobileNumber,
    FormzStatus? status,
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
    status
  ];
}