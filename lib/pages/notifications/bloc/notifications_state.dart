part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  const NotificationsState({
    this.unreadNotifications = const <Notifications>[],
    this.readNotifications = const <Notifications>[],
    this.status = Status.initial,
    this.message = ''
  });
  final List<Notifications> unreadNotifications;
  final List<Notifications> readNotifications;
  final Status status;
  final String message;

  NotificationsState copyWith({
    List<Notifications>? unreadNotifications,
    List<Notifications>? readNotifications,
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
