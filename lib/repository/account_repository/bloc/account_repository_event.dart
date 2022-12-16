part of 'account_repository_bloc.dart';

abstract class AccountRepositoryEvent extends Equatable {
  const AccountRepositoryEvent();

  @override
  List<Object> get props => [];
}

class LoadAccounts extends AccountRepositoryEvent {}

class UpdateAccounts extends AccountRepositoryEvent {
  const UpdateAccounts(this.accounts);
  final List<Account> accounts;

  @override
  List<Object> get props => [accounts];
}

