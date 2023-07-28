part of 'account_register_bloc.dart';

abstract class AccountRegisterEvent extends Equatable {
  const AccountRegisterEvent();

  @override
  List<Object> get props => [];
}

class AccountNumberChanged extends AccountRegisterEvent {
  const AccountNumberChanged(this.accountNumber);
  final String accountNumber;

  @override
  List<Object> get props => [accountNumber];
}

class AccountNameChanged extends AccountRegisterEvent {
  const AccountNameChanged(this.name);
  final String name;

  @override
  List<Object> get props => [name];
}

class AccountFormSubmitted extends AccountRegisterEvent {}
