part of 'create_pin_bloc.dart';

abstract class CreatePinEvent extends Equatable {
  const CreatePinEvent();

  @override
  List<Object> get props => [];
}

class CreatePinAdded extends CreatePinEvent {
  const CreatePinAdded(this.pin);
  final int pin;

  @override
  List<Object> get props => [pin];
}

class CreatePinErased extends CreatePinEvent {}

class CreatePinNulled extends CreatePinEvent {}