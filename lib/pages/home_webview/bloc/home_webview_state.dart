part of 'home_webview_bloc.dart';

abstract class HomeWebviewState extends Equatable {
  const HomeWebviewState();
  
  @override
  List<Object> get props => [];
}

class HomeWebviewLoading extends HomeWebviewState {}

class HomeWebviewLoaded extends HomeWebviewState {
  const HomeWebviewLoaded(this.displayModel);
  final DisplayModel displayModel;

  @override
  List<Object> get props => [displayModel];
}

class HomeWebviewLoadFailure extends HomeWebviewState {
  const HomeWebviewLoadFailure(this.error);
  final String error;
  
  @override
  List<Object> get props => [error];
}
