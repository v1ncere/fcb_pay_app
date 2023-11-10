part of 'create_pin_bloc.dart';

abstract class CreatePinEvent extends Equatable {
  const CreatePinEvent();

  @override
  List<Object> get props => [];
}

class CreatePinAdded extends CreatePinEvent {
  const CreatePinAdded(this.pinNum);
  final int pinNum;

  @override
  List<Object> get props => [pinNum];
}

class CreatePinErased extends CreatePinEvent {}

class CreatePinNulled extends CreatePinEvent {}