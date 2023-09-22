part of 'account_display_bloc.dart';

abstract class AccountDisplayEvent extends Equatable {
  const AccountDisplayEvent();

  @override
  List<Object> get props => [];
}

class AccountDisplayLoaded extends AccountDisplayEvent {}

class AccountDisplayUpdated extends AccountDisplayEvent {
  const AccountDisplayUpdated(this.accounts);
  final List<Account> accounts;

  @override
  List<Object> get props => [accounts];
}
