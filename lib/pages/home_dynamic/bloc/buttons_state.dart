part of 'buttons_bloc.dart';

sealed class ButtonsState extends Equatable {
  const ButtonsState();
  
  @override
  List<Object> get props => [];
}

final class ButtonsInitial extends ButtonsState {}
