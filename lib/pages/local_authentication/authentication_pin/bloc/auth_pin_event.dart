part of 'auth_pin_bloc.dart';

sealed class AuthPinEvent extends Equatable {
  const AuthPinEvent();
  
  @override
  List<Object> get props => [];
}

final class AuthPinAdded extends AuthPinEvent {
  const AuthPinAdded(this.pinNum);
  final int pinNum;

  @override
  List<Object> get props => [pinNum];
}

final class AuthPinErased extends AuthPinEvent {}

final class AuthPinNulled extends AuthPinEvent {}

