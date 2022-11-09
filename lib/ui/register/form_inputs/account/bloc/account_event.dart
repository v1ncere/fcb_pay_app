part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends AccountEvent {
  const EmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends AccountEvent {
  const PasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

class ConfirmedPasswordChanged extends AccountEvent {
  const ConfirmedPasswordChanged(this.password, this.confirmPassword);
  final String confirmPassword;
  final String password;

  @override
  List<Object> get props => [confirmPassword, password];
}
