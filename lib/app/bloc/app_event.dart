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

class AccountArgumentPassed extends AppEvent {
  const AccountArgumentPassed(this.args);
  final String args;

  @override
  List<Object> get props => [args];
}

class NotificationIdPassed extends AppEvent {
  const NotificationIdPassed(this.args);
  final String args;

  @override
  List<Object> get props => [args];
}

class DynamicButtonDataPassed extends AppEvent {
  const DynamicButtonDataPassed(this.buttonModel);
  final ButtonModel buttonModel;

  @override
  List<Object> get props => [buttonModel];
}

class AppLogoutRequested extends AppEvent {}
