import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fcb_pay_app/utils/utils.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc({
    required FirebaseRealtimeDBRepository firebaseRealtimeDBRepository,
  }) : _realtimeDBRepository = firebaseRealtimeDBRepository,
  super(const NotificationsState(status: Status.loading)) {
    on<NotificationsLoaded>(_onNotificationsLoaded);
    on<NotificationsUpdated>(_onNotificationsUpdated);
    on<NotificationsUpdateIsRead>(_onNotificationsUpdateIsRead);
  }
  final FirebaseRealtimeDBRepository _realtimeDBRepository;
  StreamSubscription<List<Notifications>>? _streamSubscription;

  void _onNotificationsLoaded(NotificationsLoaded event, Emitter<NotificationsState> emit) async {
    _streamSubscription?.cancel();
    _streamSubscription = _realtimeDBRepository.getNotificationListStream()
    .listen((notifications) {
      add(NotificationsUpdated(notifications: notifications));
    });
  }

  void _onNotificationsUpdated(NotificationsUpdated event, Emitter<NotificationsState> emit) async {
    final unread = event.notifications.where((notification) => !notification.isRead).toList();
    final read = event.notifications.where((notification) => notification.isRead).toList();

    if (event.notifications.isEmpty) {
      emit(state.copyWith(
        message: 'Empty',
        status: Status.error
      ));
    } else {
      emit(state.copyWith(
        unreadNotifications: unread,
        readNotifications: read,
        status: Status.success
      ));
    }
  }

  void _onNotificationsUpdateIsRead(NotificationsUpdateIsRead event, Emitter<NotificationsState> emit) async {
    try {
      await _realtimeDBRepository.updateNotificationRead(event.id);
    } catch (e) {
      emit(state.copyWith(message: e.toString()));
    }
  }


  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
