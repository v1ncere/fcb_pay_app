part of 'home_display_bloc.dart';

abstract class HomeDisplayState extends Equatable {
  const HomeDisplayState();
  
  @override
  List<Object> get props => [];
}

class HomeDisplayLoadInProgress extends HomeDisplayState {}

class HomeDisplayLoadSuccess extends HomeDisplayState {
  const HomeDisplayLoadSuccess({this.homeDisplay = const <HomeDisplay>[]});
  final List<HomeDisplay> homeDisplay;

  @override
  List<Object> get props => [homeDisplay];
}

class HomeDisplayLoadError extends HomeDisplayState {
  const HomeDisplayLoadError(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
