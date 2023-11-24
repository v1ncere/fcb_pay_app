part of 'auth_pin_bloc.dart';

class AuthPinState extends Equatable {
  const AuthPinState({
    this.pin = '',
    this.status = AuthPinStatus.enterPin,
    this.isPinExist = false,
  });
  final String pin;
  final AuthPinStatus status;
  final bool isPinExist;
  
  AuthPinState copyWith({
    String? pin,
    AuthPinStatus? status,
    bool? isPinExist
  }) {
    return AuthPinState(
      pin: pin ?? this.pin,
      status: status ?? this.status,
      isPinExist: isPinExist ?? this.isPinExist 
    );
  }

  int getCountsOfPIN() => pin.length;
  
  @override
  List<Object> get props => [pin, status, isPinExist];
}

enum AuthPinStatus { enterPin, equals , unequals }

extension AuthPinStatusX on AuthPinStatus {
  bool get isEnterPin => this == AuthPinStatus.enterPin;
  bool get isEquals => this == AuthPinStatus.equals;
  bool get isUnequals => this == AuthPinStatus.unequals;
}