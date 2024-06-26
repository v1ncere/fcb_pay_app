part of 'router_bloc.dart';

sealed class RouterEvent extends Equatable {
  const RouterEvent();

  @override
  List<Object> get props => [];
}

final class RouterAccountsPassed extends RouterEvent {
  const RouterAccountsPassed(this.account);
  final Account account;

  @override
  List<Object> get props => [account];
}

final class RouterNotificationArgsPassed extends RouterEvent {
  const RouterNotificationArgsPassed(this.args);
  final String args;

  @override
  List<Object> get props => [args];
}

final class RouterPaymentsButtonPassed extends RouterEvent {
  const RouterPaymentsButtonPassed(this.button);
  final Button button;

  @override
  List<Object> get props => [button];
}

final class RouterTransfersButtonPassed extends RouterEvent {
  const RouterTransfersButtonPassed(this.button);
  final Button button;

  @override
  List<Object> get props => [button];
}

final class RouterAccountsButtonPassed extends RouterEvent {
  const RouterAccountsButtonPassed(this.button);
  final Button button;

  @override
  List<Object> get props => [button];
}