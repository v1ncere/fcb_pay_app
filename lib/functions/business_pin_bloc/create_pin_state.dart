part of 'create_pin_bloc.dart';

enum PinStatus { enterFirst, enterSecond, equals, unequals }

@immutable
class CreatePinState {
  final PinStatus pinStatus;
  final String firstPin;
  final String secondPin;

  const CreatePinState({this.firstPin = "", this.secondPin = "", required this.pinStatus});

  int getCountOfPin() {
    if (firstPin.length < 4) {
      return firstPin.length;
    } else {
      return secondPin.length;
    }
  }

  CreatePinState copyWith({PinStatus? pinStatus, String? firstPin, String? secondPin}) {
    return CreatePinState(
      pinStatus: pinStatus ?? this.pinStatus,
      firstPin: firstPin ?? this.firstPin,
      secondPin: secondPin ?? this.secondPin,
    );
  }
}