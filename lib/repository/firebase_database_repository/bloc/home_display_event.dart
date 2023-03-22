part of 'home_display_bloc.dart';

abstract class HomeDisplayEvent extends Equatable {
  const HomeDisplayEvent();

  @override
  List<Object> get props => [];
}

class HomeDisplayLoaded extends HomeDisplayEvent {}

class HomeDisplayUpdated extends HomeDisplayEvent {
  const HomeDisplayUpdated(this.homeDisplay);
  final HomeDisplay homeDisplay;

  @override
  List<Object> get props => [homeDisplay];
}
