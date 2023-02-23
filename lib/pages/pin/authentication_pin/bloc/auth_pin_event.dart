part of 'auth_pin_bloc.dart';

@immutable
abstract class AuthPinEvent {
  const AuthPinEvent({
    this.pinNum
  });
  final int? pinNum;
}

class AuthPinAddEvent extends AuthPinEvent {
  const AuthPinAddEvent({
    required int pinNum
  }) : super(pinNum: pinNum);
}

class AuthPinEraseEvent extends AuthPinEvent {
  const AuthPinEraseEvent() : super();
}

class AuthNullPinEvent extends AuthPinEvent {
  const AuthNullPinEvent() : super();
}