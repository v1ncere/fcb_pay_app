part of 'accounts_bloc.dart';

sealed class AccountsEvent extends Equatable {
  const AccountsEvent();

  @override
  List<Object> get props => [];
}

final class AccountsLoaded extends AccountsEvent {}

final class AccountsUpdated extends AccountsEvent {
  const AccountsUpdated(this.accounts);
  final List<Account> accounts;

  @override
  List<Object> get props => [accounts];
}