part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
  
  @override
  List<Object> get props => [];
}

class AppUserChanged extends AppEvent {
  const AppUserChanged(this.user);
  final User user;

  @override
  List<Object> get props => [user];
}

class AppAccountsModelPassed extends AppEvent {
  const AppAccountsModelPassed(this.accountModel);
  final AccountModel accountModel;

  @override
  List<Object> get props => [accountModel];
}

class AppNotificationArgsPassed extends AppEvent {
  const AppNotificationArgsPassed(this.args);
  final String args;

  @override
  List<Object> get props => [args];
}

class AppDynamicButtonModelPassed extends AppEvent {
  const AppDynamicButtonModelPassed(this.buttonModel);
  final ButtonModel buttonModel;

  @override
  List<Object> get props => [buttonModel];
}

class AppAccountDynamicButtonModelPassed extends AppEvent {
  const AppAccountDynamicButtonModelPassed(this.buttonModel);
  final ButtonModel buttonModel;

  @override
  List<Object> get props => [buttonModel];
}

class AppLogoutRequested extends AppEvent {}
