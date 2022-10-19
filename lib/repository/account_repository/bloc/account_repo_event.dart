part of 'account_repo_bloc.dart';

abstract class AccountRepoEvent extends Equatable {
  const AccountRepoEvent();

  @override
  List<Object> get props => [];
}

class LoadAccounts extends AccountRepoEvent {}

class UpdateAccounts extends AccountRepoEvent {
  final List<AccountModel> accounts;
  const UpdateAccounts(this.accounts);

  @override
  List<Object> get props => [accounts];
}
