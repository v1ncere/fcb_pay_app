import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/notifications/notifications.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: NotificationPage());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseRealtimeDBRepository(),
      child: BlocProvider(
        create: (context) => NotificationsBloc(
          firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository()
        )..add(NotificationsLoaded()),
        child: const NotificationView()
      )
    );
  }
}