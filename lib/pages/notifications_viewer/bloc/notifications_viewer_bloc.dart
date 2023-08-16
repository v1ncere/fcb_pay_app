import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifications_viewer_event.dart';
part 'notifications_viewer_state.dart';

class NotificationsViewerBloc extends Bloc<NotificationsViewerEvent, NotificationsViewerState> {
  NotificationsViewerBloc({
    required FirebaseRealtimeDBRepository firebaseRealtimeDBRepository,
  })  : _realtimeDBRepository = firebaseRealtimeDBRepository,
  super(NotificationsViewerLoading()) {
    on<NotificationViewerLoaded>(_onNotificationViewerLoaded);
    on<NotificationDelete>(_onNotificationDelete);
  }
  final FirebaseRealtimeDBRepository _realtimeDBRepository;

  void _onNotificationViewerLoaded(NotificationViewerLoaded event, Emitter<NotificationsViewerState> emit) async {
    try {
      final notification = await _realtimeDBRepository.getNotification(event.id);
      emit(NotificationsViewerSuccess(notification: notification));
    } catch (err) {
      emit(NotificationsViewerError(message: err.toString()));
    }
  }
  void _onNotificationDelete(NotificationDelete event, Emitter<NotificationsViewerState> emit) async {
    try {
      await _realtimeDBRepository.deleteNotificationRead(event.id);
    } catch (err) {
      throw(Exception(err));
    }
  }

}
