part of 'notifications_viewer_bloc.dart';

abstract class NotificationsViewerState extends Equatable {
  const NotificationsViewerState();

  @override
  List<Object> get props => [];
}

class NotificationsViewerLoading extends NotificationsViewerState {}

class NotificationsViewerSuccess extends NotificationsViewerState {
  const NotificationsViewerSuccess({required this.notification});
  final Notification notification;

  @override
  List<Object> get props => [notification];
}

class NotificationsViewerError extends NotificationsViewerState {
  const NotificationsViewerError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}