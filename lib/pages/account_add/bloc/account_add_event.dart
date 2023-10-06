part of 'account_add_bloc.dart';

sealed class AccountAddEvent extends Equatable {
  const AccountAddEvent();

  @override
  List<Object> get props => [];
}

final class AccountNumberChanged extends AccountAddEvent {
  const AccountNumberChanged(this.accountNumber);
  final String accountNumber;

  @override
  List<Object> get props => [accountNumber];
}

final class AccountNameChanged extends AccountAddEvent {
  const AccountNameChanged(this.name);
  final String name;

  @override
  List<Object> get props => [name];
}

final class AccountStatusRefresher extends AccountAddEvent {}

final class AccountFormSubmitted extends AccountAddEvent {}
