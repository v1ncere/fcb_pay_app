part of 'account_cubit.dart';

class AccountState extends Equatable {
  const AccountState({
    this.account = const <Account>[],
  });
  final List<Account> account;

  @override
  List<Object> get props => [account];
}

