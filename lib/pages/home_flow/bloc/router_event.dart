part of 'router_bloc.dart';

sealed class RouterEvent extends Equatable {
  const RouterEvent();

  @override
  List<Object> get props => [];
}

final class RouterAccountsModelPassed extends RouterEvent {
  const RouterAccountsModelPassed(this.accountModel);
  final AccountModel accountModel;

  @override
  List<Object> get props => [accountModel];
}

final class RouterNotificationArgsPassed extends RouterEvent {
  const RouterNotificationArgsPassed(this.args);
  final String args;

  @override
  List<Object> get props => [args];
}

final class RouterDynamicButtonModelPassed extends RouterEvent {
  const RouterDynamicButtonModelPassed(this.buttonModel);
  final ButtonModel buttonModel;

  @override
  List<Object> get props => [buttonModel];
}

final class RouterAccountDynamicButtonModelPassed extends RouterEvent {
  const RouterAccountDynamicButtonModelPassed(this.buttonModel);
  final ButtonModel buttonModel;

  @override
  List<Object> get props => [buttonModel];
}