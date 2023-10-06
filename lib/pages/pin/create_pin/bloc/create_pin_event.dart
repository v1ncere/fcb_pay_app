part of 'create_pin_bloc.dart';

abstract class CreatePinEvent extends Equatable {
  const CreatePinEvent();

  @override
  List<Object> get props => [];
}

class CreatePinAddEvent extends CreatePinEvent {
  const CreatePinAddEvent(this.pinNum);
  final int pinNum;

  @override
  List<Object> get props => [pinNum];
}

class CreatePinEraseEvent extends CreatePinEvent {}

class CreateNullPinEvent extends CreatePinEvent {}