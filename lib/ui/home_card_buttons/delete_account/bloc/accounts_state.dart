part of 'accounts_bloc.dart';

abstract class AccountsState extends Equatable {
  const AccountsState();
  
  @override
  List<Object> get props => [];
}

class AccountsInitialState extends AccountsState {}

class AccountsLoadingState extends AccountsState {}

class AccountsNewState extends AccountsState {}

class AccountsEditState extends AccountsState {
  const AccountsEditState({ required this.account });
  final Account account;

  @override
  List<Object> get props => [account];
}

class AccountsLoadedState extends AccountsState {
  const AccountsLoadedState({required this.accounts});
  final List<Account> accounts;

  @override
  List<Object> get props => [accounts];
}
