part of 'home_webview_bloc.dart';

abstract class HomeWebviewEvent extends Equatable {
  const HomeWebviewEvent();

  @override
  List<Object> get props => [];
}

class HomeWebviewLoadRequested extends HomeWebviewEvent {}


