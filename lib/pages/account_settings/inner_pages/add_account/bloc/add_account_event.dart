part of 'add_account_bloc.dart';

abstract class AddAccountEvent extends Equatable {
  const AddAccountEvent();

  @override
  List<Object> get props => [];
}

class AccountNumberChanged extends AddAccountEvent {
  const AccountNumberChanged(this.accountNumber);
  final String accountNumber;

  @override
  List<Object> get props => [accountNumber];
}

class AccountNameChanged extends AddAccountEvent {
  const AccountNameChanged(this.name);
  final String name;

  @override
  List<Object> get props => [name];
}

class AccountFormSubmitted extends AddAccountEvent {}
