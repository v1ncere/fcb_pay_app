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

class AppLogoutRequested extends AppEvent {}
