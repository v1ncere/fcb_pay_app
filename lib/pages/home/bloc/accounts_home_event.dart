part of 'accounts_home_bloc.dart';

sealed class AccountsHomeEvent extends Equatable {
  const AccountsHomeEvent();

  @override
  List<Object> get props => [];
}

final class AccountsHomeLoaded extends AccountsHomeEvent {}

final class AccountsHomeUpdated extends AccountsHomeEvent {
  const AccountsHomeUpdated(this.accountList);
  final List<Account> accountList;

  @override
  List<Object> get props => [accountList];
}

final class UserDetailsStreamed extends AccountsHomeEvent {}

final class UserDetailsUpdated extends AccountsHomeEvent {
  const UserDetailsUpdated(this.userDetails);
  final UserDetails userDetails;

  @override
  List<Object> get props => [userDetails];
}

final class DepositDisplayChanged extends AccountsHomeEvent {
  const DepositDisplayChanged(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}

final class CreditDisplayChanged extends AccountsHomeEvent {
  const CreditDisplayChanged(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}

final class AccountsHomeRefreshed extends AccountsHomeEvent {}