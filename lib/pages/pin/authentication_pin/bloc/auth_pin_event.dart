part of 'auth_pin_bloc.dart';

abstract class AuthPinEvent extends Equatable {
  const AuthPinEvent();
  
  @override
  List<Object> get props => [];
}

class AuthPinAddEvent extends AuthPinEvent {
  const AuthPinAddEvent(this.pinNum);
  final int pinNum;

  @override
  List<Object> get props => [pinNum];
}

class AuthPinEraseEvent extends AuthPinEvent {}

class AuthNullPinEvent extends AuthPinEvent {}

// @immutable
// abstract class AuthPinEvent {
//   const AuthPinEvent({
//     this.pinNum
//   });
//   final int? pinNum;
// }

// class AuthPinAddEvent extends AuthPinEvent {
//   const AuthPinAddEvent({
//     required int pinNum
//   }) : super(pinNum: pinNum);
// }

// class AuthPinEraseEvent extends AuthPinEvent {
//   const AuthPinEraseEvent() : super();
// }

// class AuthNullPinEvent extends AuthPinEvent {
//   const AuthNullPinEvent() : super();
// }

