part of 'accounts_bloc.dart';

sealed class AccountsState extends Equatable {
  const AccountsState();
  
  @override
  List<Object> get props => [];
}

final class AccountsInProgress extends AccountsState {}

final class AccountsSuccess extends AccountsState {
  const AccountsSuccess({this.accounts = const <Account>[]});
  final List<Account> accounts;

  @override
  List<Object> get props => [accounts];
}

final class AccountsError extends AccountsState {
  const AccountsError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}