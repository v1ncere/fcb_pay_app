part of 'inputs_bloc.dart';

abstract class InputsEvent extends Equatable {
  const InputsEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends InputsEvent {
  const EmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends InputsEvent {
  const PasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

class ConfirmedPasswordChanged extends InputsEvent {
  const ConfirmedPasswordChanged(this.password, this.confirmPassword);
  final String confirmPassword;
  final String password;

  @override
  List<Object> get props => [confirmPassword, password];
}

class HomeAddressChanged extends InputsEvent {
  const HomeAddressChanged(this.homeAddress);
  final String homeAddress;

  @override
  List<Object> get props => [homeAddress];
}

class AccountNumberChanged extends InputsEvent {
  const AccountNumberChanged(this.accountNumber);
  final String accountNumber;

  @override
  List<Object> get props => [accountNumber];
}

class MobileNumberChanged extends InputsEvent {
  const MobileNumberChanged(this.mobileNumber);
  final String mobileNumber;

  @override
  List<Object> get props => [mobileNumber];
}

class FormSubmitted extends InputsEvent {}
