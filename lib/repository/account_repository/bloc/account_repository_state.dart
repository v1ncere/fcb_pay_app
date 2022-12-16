part of 'account_repository_bloc.dart';

abstract class AccountRepositoryState extends Equatable {
  const AccountRepositoryState();
  
  @override
  List<Object> get props => [];
}

class AccountLoading extends AccountRepositoryState {}

class AccountLoaded extends AccountRepositoryState {
  const AccountLoaded({
    this.account = const <Account>[]
  });
  final List<Account> account;

  @override
  List<Object> get props => [account];
}