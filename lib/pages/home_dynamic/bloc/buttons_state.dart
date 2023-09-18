part of 'buttons_bloc.dart';

sealed class ButtonsState extends Equatable {
  const ButtonsState();
  
  @override
  List<Object> get props => [];
}

final class ButtonsLoading extends ButtonsState {}

final class ButtonsSuccess extends ButtonsState {
  const ButtonsSuccess(this.homeButtons);
  final List<HomeButton> homeButtons;

  @override
  List<Object> get props => [homeButtons];
}

final class ButtonsError extends ButtonsState {
  const ButtonsError({required this.error});
  final String error;

  @override
  List<Object> get props => [error];
}