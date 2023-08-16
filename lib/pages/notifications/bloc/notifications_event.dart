part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class NotificationsLoaded extends NotificationsEvent {}

class NotificationsUpdated extends NotificationsEvent {
  const NotificationsUpdated({required this.notifications});
  final List<Notifications> notifications;
  
  @override
  List<Object> get props => [notifications];
}

class NotificationsUpdateIsRead extends NotificationsEvent {
  const NotificationsUpdateIsRead(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}