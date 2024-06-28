part of 'update_pin_bloc.dart';

class UpdatePinState extends Equatable {
  const UpdatePinState({
    required this.status,
    this.currentPin = '',
    this.newPin = '',
    this.confirmedPin = ''
  });
  final UpdatePinStatus status;
  final String currentPin;
  final String newPin;
  final String confirmedPin;

  UpdatePinState copyWith({
    UpdatePinStatus? status,
    String? currentPin,
    String? newPin,
    String? confirmedPin
  }) {
    return UpdatePinState(
      status: status ?? this.status,
      currentPin: currentPin ?? this.currentPin,
      newPin: newPin ?? this.newPin,
      confirmedPin: confirmedPin ?? this.confirmedPin
    );
  }

  int getPinLength() {
    if (currentPin.length < 6) {
      return currentPin.length;
    } else {
      return newPin.length < 6 ? newPin.length : confirmedPin.length;
    }
  }
  
  @override
  List<Object> get props => [status, currentPin, newPin, confirmedPin];
}

enum UpdatePinStatus {
  enterCurrent,
  enterNew,
  enterConfirm,
  currentEquals,
  currentUnequals,
  updateEquals,
  updateUnequals 
}

extension UpdatePinStatusX on UpdatePinStatus {
  bool get isEnterCurrent => this == UpdatePinStatus.enterCurrent;
  bool get isEnterNew => this == UpdatePinStatus.enterNew;
  bool get isEnterConfirm => this == UpdatePinStatus.enterConfirm;
  bool get isCurrentEquals => this == UpdatePinStatus.currentEquals;
  bool get isCurrentUnequals => this == UpdatePinStatus.currentUnequals;
  bool get isUpdateEquals => this == UpdatePinStatus.updateEquals;
  bool get isUpdateUnequals => this == UpdatePinStatus.updateUnequals;
}
