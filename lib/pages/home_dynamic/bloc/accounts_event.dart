part of 'accounts_bloc.dart';

sealed class AccountsEvent extends Equatable {
  const AccountsEvent();

  @override
  List<Object> get props => [];
}

final class AccountDisplayLoaded extends AccountsEvent {}

final class AccountDisplayUpdated extends AccountsEvent {
  const AccountDisplayUpdated(this.accounts);
  final List<Accounts> accounts;

  @override
  List<Object> get props => [accounts];
}