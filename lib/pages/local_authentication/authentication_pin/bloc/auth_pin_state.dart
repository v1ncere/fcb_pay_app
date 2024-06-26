part of 'auth_pin_bloc.dart';

class AuthPinState extends Equatable {
  const AuthPinState({
    this.pin = '',
    this.status = AuthPinStatus.enterPin
  });
  final String pin;
  final AuthPinStatus status;
  
  AuthPinState copyWith({
    String? pin,
    AuthPinStatus? status
  }) {
    return AuthPinState(
      pin: pin ?? this.pin,
      status: status ?? this.status
    );
  }

  int getCountsOfPIN() => pin.length;
  
  @override
  List<Object> get props => [pin, status];
}

enum AuthPinStatus { enterPin, equals , unequals }

extension AuthPinStatusX on AuthPinStatus {
  bool get isEnterPin => this == AuthPinStatus.enterPin;
  bool get isEquals => this == AuthPinStatus.equals;
  bool get isUnequals => this == AuthPinStatus.unequals;
}