part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  const NotificationsState({
    this.unreadNotifications = const <Notification>[],
    this.readNotifications = const <Notification>[],
    this.status = Status.initial,
    this.message = ''
  });
  final List<Notification> unreadNotifications;
  final List<Notification> readNotifications;
  final Status status;
  final String message;

  NotificationsState copyWith({
    List<Notification>? unreadNotifications,
    List<Notification>? readNotifications,
    Status? status,
    String? message
  }) {
    return NotificationsState(
      unreadNotifications: unreadNotifications ?? this.unreadNotifications,
      readNotifications: readNotifications ?? this.readNotifications,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [unreadNotifications, readNotifications, status, message];
}
