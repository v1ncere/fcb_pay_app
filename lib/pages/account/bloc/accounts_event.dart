part of 'accounts_bloc.dart';

sealed class AccountsEvent extends Equatable {
  const AccountsEvent();

  @override
  List<Object> get props => [];
}

final class AccountsLoaded extends AccountsEvent {
  const AccountsLoaded(this.account);
  final Account account;

  @override 
  List<Object> get props => [account];
}

final class AccountsUpdated extends AccountsEvent {
  const AccountsUpdated(this.accountList, this.account);
  final List<Account> accountList;
  final Account account;

  @override
  List<Object> get props => [accountList, account];
}

final class AccountsRefreshed extends AccountsEvent {
  const AccountsRefreshed(this.account);
  final Account account;

  @override 
  List<Object> get props => [account];
}

final class AccountsBalanceRequested extends AccountsEvent {
  const AccountsBalanceRequested(this.account);
  final Account account;

  @override
  List<Object> get props => [account];
}