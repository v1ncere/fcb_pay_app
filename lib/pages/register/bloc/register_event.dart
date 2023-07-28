part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends RegisterEvent {
  const EmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends RegisterEvent {
  const PasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

class ConfirmedPasswordChanged extends RegisterEvent {
  const ConfirmedPasswordChanged(this.password, this.confirmPassword);
  final String confirmPassword;
  final String password;

  @override
  List<Object> get props => [confirmPassword, password];
}


class MobileNumberChanged extends RegisterEvent {
  const MobileNumberChanged(this.mobileNumber);
  final String mobileNumber;

  @override
  List<Object> get props => [mobileNumber];
}

class FormSubmitted extends RegisterEvent {}