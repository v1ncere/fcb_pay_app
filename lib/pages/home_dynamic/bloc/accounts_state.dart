part of 'accounts_bloc.dart';

sealed class AccountsState extends Equatable {
  const AccountsState();
  
  @override
  List<Object> get props => [];
}

final class AccountDisplayInProgress extends AccountsState {}

final class AccountDisplaySuccess extends AccountsState {
  const AccountDisplaySuccess({this.accounts = const <Accounts>[]});
  final List<Accounts> accounts;

  @override
  List<Object> get props => [accounts];
}

final class AccountDisplayError extends AccountsState {
  const AccountDisplayError(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}