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
  const AccountsError(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}