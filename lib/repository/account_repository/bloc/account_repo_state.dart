part of 'account_repo_bloc.dart';

abstract class AccountRepoState extends Equatable {
  const AccountRepoState();
  
  @override
  List<Object> get props => [];
}

class AccountLoading extends AccountRepoState {}

class AccountLoaded extends AccountRepoState {
  final List<AccountModel> accountModel;
  const AccountLoaded({this.accountModel = const <AccountModel>[]});

  @override
  List<Object> get props => [accountModel];
}
