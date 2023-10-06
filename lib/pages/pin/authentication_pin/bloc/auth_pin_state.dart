part of 'auth_pin_bloc.dart';

enum AuthPinStatus { enterPin, equals , unequals }

class AuthPinState extends Equatable {
  const AuthPinState({
    this.pin = '',
    this.pinStatus = AuthPinStatus.enterPin
  });
  final String pin;
  final AuthPinStatus pinStatus;

  AuthPinState copyWith({
    String? pin,
    AuthPinStatus? pinStatus
  }) {
    return AuthPinState(
      pin: pin ?? this.pin,
      pinStatus: pinStatus ?? this.pinStatus, 
    );
  }

  int getCountsOfPIN() {
    return pin.length;
  }
  
  @override
  List<Object?> get props => [pinStatus, pin];
}