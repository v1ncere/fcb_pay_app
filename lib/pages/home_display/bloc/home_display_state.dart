part of 'home_display_bloc.dart';

abstract class HomeDisplayState extends Equatable {
  const HomeDisplayState();
  
  @override
  List<Object> get props => [];
}

class HomeDisplayLoading extends HomeDisplayState {}

class HomeDisplayLoad extends HomeDisplayState {
  // const HomeDisplayLoad({required this.homeDisplay});
  // final HomeDisplay homeDisplay;

  const HomeDisplayLoad({this.homeDisplay = const <HomeDisplay>[]}); // list
  final List<HomeDisplay> homeDisplay; // list

  @override
  List<Object> get props => [homeDisplay];
}

class HomeDisplayError extends HomeDisplayState {
  const HomeDisplayError(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
