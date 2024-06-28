part of 'create_pin_bloc.dart';

class CreatePinState extends Equatable {
  const CreatePinState({
    required this.status,
    this.newPin = '',
    this.confirmedPin = ''
  });
  final PinStatus status;
  final String newPin;
  final String confirmedPin;

  CreatePinState copyWith({
    PinStatus? status,
    String? newPin,
    String? confirmedPin
  }) {
    return CreatePinState(
      status: status ?? this.status,
      newPin: newPin ?? this.newPin,
      confirmedPin: confirmedPin ?? this.confirmedPin
    );
  }

  int getPinLength() => (newPin.length < 6) 
  ? newPin.length 
  : confirmedPin.length;
  
  @override
  List<Object?> get props => [status, newPin, confirmedPin];
}

enum PinStatus { enterNew, enterConfirm, equals, unequals }

extension PinStatusX on PinStatus {
  bool get isEnterNew => this == PinStatus.enterNew;
  bool get isEnterConfirm => this == PinStatus.enterConfirm;
  bool get isEquals => this == PinStatus.equals;
  bool get isUnequals => this == PinStatus.unequals;
}