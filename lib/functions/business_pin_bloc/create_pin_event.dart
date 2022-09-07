part of 'create_pin_bloc.dart';

@immutable
abstract class CreatePinEvent {
  final int? pinNum;
  const CreatePinEvent({this.pinNum});
}

class CreatePinAddEvent extends CreatePinEvent {
  const CreatePinAddEvent({required int pinNum}) : super(pinNum: pinNum);
}

class CreatePinEraseEvent extends CreatePinEvent {
  const CreatePinEraseEvent() : super();
}

class CreateNullPinEvent extends CreatePinEvent {
  const CreateNullPinEvent() : super();
}