part of 'create_pin_bloc.dart';

enum PinStatus { enterFirst, enterSecond, equals, unequals }

@immutable
class CreatePinState {
  const CreatePinState({
    this.firstPin = "",
    this.secondPin = "",
    required this.pinStatus
  });
  final PinStatus pinStatus;
  final String firstPin;
  final String secondPin;
  
  int getCountOfPin() {
    if (firstPin.length < 6) {
      return firstPin.length;
    } else {
      return secondPin.length;
    }
  }

  CreatePinState copyWith({
    PinStatus? pinStatus,
    String? firstPin,
    String? secondPin
  }) {
    return CreatePinState(
      pinStatus: pinStatus ?? this.pinStatus,
      firstPin: firstPin ?? this.firstPin,
      secondPin: secondPin ?? this.secondPin,
    );
  }
}