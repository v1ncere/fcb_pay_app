part of 'auth_pin_bloc.dart';

enum AuthPinStatus { enterPin, equals , unequals }

@immutable
class AuthPinState {
  const AuthPinState({
    required this.pinStatus,
    this.pin = ""
  });
  final AuthPinStatus pinStatus;
  final String pin;

  AuthPinState copyWith({
    AuthPinStatus? pinStatus,
    String? pin,
  }) {
    return AuthPinState(
      pinStatus: pinStatus ?? this.pinStatus, 
      pin: pin ?? this.pin,
    );
  }

  int getCountsOfPIN() {
    return pin.length;
  }
}