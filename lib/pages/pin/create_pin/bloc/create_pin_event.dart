part of 'create_pin_bloc.dart';

@immutable
abstract class CreatePinEvent {
  const CreatePinEvent({
    this.pinNum
  });
  final int? pinNum;
}

class CreatePinAddEvent extends CreatePinEvent {
  const CreatePinAddEvent({
    required int pinNum
  }) : super(pinNum: pinNum);
}

class CreatePinEraseEvent extends CreatePinEvent {
  const CreatePinEraseEvent() : super();
}

class CreateNullPinEvent extends CreatePinEvent {
  const CreateNullPinEvent() : super();
}