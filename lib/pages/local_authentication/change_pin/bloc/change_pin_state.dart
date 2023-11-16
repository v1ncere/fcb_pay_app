part of 'change_pin_bloc.dart';

sealed class ChangePinState extends Equatable {
  const ChangePinState();
  
  @override
  List<Object> get props => [];
}

final class ChangePinInitial extends ChangePinState {}
