part of 'update_pin_bloc.dart';

sealed class UpdatePinEvent extends Equatable {
  const UpdatePinEvent();

  @override
  List<Object> get props => [];
}

final class UpdatePinAdded extends UpdatePinEvent {
  const UpdatePinAdded(this.pin);
  final int pin;

  @override
  List<Object> get props => [pin];
}

final class UpdatePinErased extends UpdatePinEvent {}

final class UpdatePinNulled extends UpdatePinEvent {}
