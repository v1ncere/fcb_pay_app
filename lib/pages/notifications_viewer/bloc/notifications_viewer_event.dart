part of 'notifications_viewer_bloc.dart';

abstract class NotificationsViewerEvent extends Equatable {
  const NotificationsViewerEvent();

  @override
  List<Object> get props => [];
}

class NotificationViewerLoaded extends NotificationsViewerEvent {
  const NotificationViewerLoaded(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}

class NotificationDelete extends NotificationsViewerEvent {
  const NotificationDelete(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}