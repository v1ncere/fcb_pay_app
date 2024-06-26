part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();
  
  @override
  List<Object> get props => [];
}

final class AppUserChanged extends AppEvent {
  const AppUserChanged(this.user);
  final User user;

  @override
  List<Object> get props => [user];
}

final class AppLogoutRequested extends AppEvent {}

final class PhoneNumberPassed extends AppEvent {
  const PhoneNumberPassed(this.phoneNumber);
  final String phoneNumber;

  @override 
  List<Object> get props => [phoneNumber];
}

