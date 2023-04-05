part of 'auth_pin_bloc.dart';

enum AuthPinStatus { enterPin, equals , unequals }

class AuthPinState extends Equatable {
  const AuthPinState({
    this.pinStatus = AuthPinStatus.enterPin,
    this.pin = '',
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
  
  @override
  List<Object?> get props => [pinStatus, pin];
}

// @immutable
// class AuthPinState {
//   const AuthPinState({
//     required this.pinStatus,
//     this.pin = ""
//   });
//   final AuthPinStatus pinStatus;
//   final String pin;

//   AuthPinState copyWith({
//     AuthPinStatus? pinStatus,
//     String? pin,
//   }) {
//     return AuthPinState(
//       pinStatus: pinStatus ?? this.pinStatus, 
//       pin: pin ?? this.pin,
//     );
//   }

//   int getCountsOfPIN() {
//     return pin.length;
//   }
// }