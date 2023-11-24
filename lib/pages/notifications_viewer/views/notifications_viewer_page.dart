import 'package:fcb_pay_app/pages/bottom_appbar/bottom_appbar.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/home_flow/home_flow.dart';
import 'package:fcb_pay_app/pages/notifications_viewer/notifications_viewer.dart';

class NotificationsViewerPage extends StatelessWidget {
  const NotificationsViewerPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: NotificationsViewerPage());

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RouterBloc, RouterState, String>(
      selector: (state) => state.args,
      builder: (context, args) {
        return RepositoryProvider(
          create: (context) => FirebaseRealtimeDBRepository(),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => NotificationsViewerBloc(firebaseRepository: FirebaseRealtimeDBRepository())
              ..add(NotificationViewerLoaded(args))),
              BlocProvider(create: (context) => InactivityCubit()..resetTimer())
            ],
            child: const NotificationsViewerView(),
          )
        );
      }
    );
  }
}