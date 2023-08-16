import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/notifications_viewer/notifications_viewer.dart';

class NotificationsViewerPage extends StatelessWidget {
  const NotificationsViewerPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: NotificationsViewerPage());

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, String>(
      selector: (state) => state.args,
      builder: (context, args) {
        return RepositoryProvider(
          create: (context) => FirebaseRealtimeDBRepository(),
          child: BlocProvider(
            create: (context) => NotificationsViewerBloc(
              firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository()
            )..add(NotificationViewerLoaded(args)),
            child: const NotificationsViewerView()
          )
        );
      }
    );
  }
}