part of 'account_repository_bloc.dart';

abstract class AccountRepositoryState extends Equatable {
  const AccountRepositoryState();
  
  @override
  List<Object> get props => [];
}

class AccountLoading extends AccountRepositoryState {}

class AccountLoaded extends AccountRepositoryState {
  const AccountLoaded({
    this.accountModel = const <AccountModel>[]
  });
  final List<AccountModel> accountModel;

  @override
  List<Object> get props => [accountModel];
}