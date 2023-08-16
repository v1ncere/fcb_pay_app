import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/notifications_viewer/notifications_viewer.dart';
import 'package:fcb_pay_app/pages/notifications_viewer/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class NotificationDisplay extends StatelessWidget {
  const NotificationDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsViewerBloc, NotificationsViewerState>(
      builder: (context, state) {
        if (state is NotificationsViewerLoading) {
          return const LoadingScreen();
        }
        if (state is NotificationsViewerSuccess) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.notification.senderName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black54
                      )
                    ),
                    Text(
                      getDateString(state.notification.timeStamp),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12
                      )
                    )
                  ]
                ),
                const SizedBox(height: 10),
                Text(
                  state.notification.content,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black
                  )
                )
              ]
            ),
          );
        }
        if (state is NotificationsViewerError) {
          return Center(
            child: Text(state.message),
          );
        } 
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}