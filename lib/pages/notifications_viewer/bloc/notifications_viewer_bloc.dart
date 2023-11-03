import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifications_viewer_event.dart';
part 'notifications_viewer_state.dart';

class NotificationsViewerBloc extends Bloc<NotificationsViewerEvent, NotificationsViewerState> {
  NotificationsViewerBloc({
    required FirebaseRealtimeDBRepository firebaseRealtimeDBRepository,
  })  : _firebaseRepository = firebaseRealtimeDBRepository,
  super(NotificationsViewerLoading()) {
    on<NotificationViewerLoaded>(_onNotificationViewerLoaded);
    on<NotificationDelete>(_onNotificationDelete);
  }
  final FirebaseRealtimeDBRepository _firebaseRepository;

  void _onNotificationViewerLoaded(NotificationViewerLoaded event, Emitter<NotificationsViewerState> emit) async {
    try {
      final notification = await _firebaseRepository.getNotification(event.id);
      emit(NotificationsViewerSuccess(notification: notification));
    } catch (e) {
      emit(NotificationsViewerError(message: e.toString()));
    }
  }
  void _onNotificationDelete(NotificationDelete event, Emitter<NotificationsViewerState> emit) async {
    try {
      await _firebaseRepository.deleteNotificationRead(event.id);
    } catch (e) {
      throw(Exception(e));
    }
  }

}
