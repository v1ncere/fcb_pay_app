part of 'auth_pin_bloc.dart';

class AuthPinState extends Equatable {
  const AuthPinState({
    this.pin = '',
    this.pinStatus = AuthPinStatus.enterPin,
    this.pinChecker
  });
  final String pin;
  final AuthPinStatus pinStatus;
  final bool? pinChecker;

  AuthPinState copyWith({
    String? pin,
    AuthPinStatus? pinStatus,
    bool? pinChecker
  }) {
    return AuthPinState(
      pin: pin ?? this.pin,
      pinStatus: pinStatus ?? this.pinStatus,
      pinChecker: pinChecker ?? this.pinChecker 
    );
  }

  int getCountsOfPIN() {
    return pin.length;
  }
  
  @override
  List<Object?> get props => [pinStatus, pin, pinChecker];
}

enum AuthPinStatus { enterPin, equals , unequals }

extension AuthPinStatusX on AuthPinStatus {
  bool get isEnterPin => this == AuthPinStatus.enterPin;
  bool get isEquals => this == AuthPinStatus.equals;
  bool get isUnequals => this == AuthPinStatus.unequals;
}