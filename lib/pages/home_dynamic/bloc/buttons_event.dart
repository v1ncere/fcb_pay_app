part of 'buttons_bloc.dart';

sealed class ButtonsEvent extends Equatable {
  const ButtonsEvent();

  @override
  List<Object> get props => [];
}

final class ButtonsLoaded extends ButtonsEvent {}

final class ButtonsUpdated extends ButtonsEvent {
  const ButtonsUpdated(this.homeButton);
  final List<HomeButton> homeButton;

  @override
  List<Object> get props => [homeButton];
}