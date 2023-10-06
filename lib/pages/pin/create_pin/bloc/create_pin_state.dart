part of 'create_pin_bloc.dart';

enum PinStatus { enterFirst, enterSecond, equals, unequals }

class CreatePinState extends Equatable {
  const CreatePinState({
    this.firstPin = "",
    this.secondPin = "",
    required this.pinStatus
  });
  final PinStatus pinStatus;
  final String firstPin;
  final String secondPin;

  CreatePinState copyWith({
    PinStatus? pinStatus,
    String? firstPin,
    String? secondPin
  }) {
    return CreatePinState(
      pinStatus: pinStatus ?? this.pinStatus,
      firstPin: firstPin ?? this.firstPin,
      secondPin: secondPin ?? this.secondPin
    );
  }

  int getCountOfPin() {
    if (firstPin.length < 6) {
      return firstPin.length;
    } else {
      return secondPin.length;
    }
  }
  
  @override
  List<Object?> get props => [pinStatus, firstPin, secondPin];
}