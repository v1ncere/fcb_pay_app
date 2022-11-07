part of 'register_cubit.dart';

enum ConfirmPasswordValidator { invalid }

class RegisterState extends Equatable {
  const RegisterState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.mobileNumber = const MobileNumber.pure(),
    this.postalCode = const Number.pure(),
    this.address = const Letter.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final MobileNumber mobileNumber;
  final Number postalCode;
  final Letter address;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [
    email,
    password,
    confirmedPassword,
    mobileNumber,
    postalCode,
    address,
    status,
  ];

  RegisterState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    MobileNumber? mobileNumber,
    Number? postalCode,
    Letter? address,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      postalCode: postalCode ?? this.postalCode,
      address: address ?? this.address,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
