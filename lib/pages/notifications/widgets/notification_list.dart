import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/notifications/notifications.dart';
import 'package:fcb_pay_app/pages/notifications/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsBloc, NotificationsState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: ShimmerListTile(),
          );
        }
        if (state.status.isSuccess) {
          final notifications = [...state.unreadNotifications, ...state.readNotifications]; // merged unread and read notifications
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListView.builder(
              itemCount: notifications.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final notif = notifications[index];
                final isRead = notif.isRead;
                
                return Container(
                  color: isRead ? const Color.fromARGB(15, 0, 0, 0) : null,
                  child: ListTile(
                    key: ValueKey(notif),
                    leading: isRead
                    ? const Icon(FontAwesomeIcons.solidEnvelope, color: Color.fromARGB(193, 76, 175, 79))
                    : const Badge(
                      largeSize: 8,
                      smallSize: 8,
                      child: Icon(FontAwesomeIcons.solidEnvelope),
                    ),
                    title: Text(
                      notif.senderName,
                      style: TextStyle(
                        color: isRead ? Colors.black54 : Colors.black,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600
                      )
                    ),
                    subtitle: Text(
                      notif.content,
                      style: TextStyle(
                        color: isRead ? Colors.black54 : Colors.black87,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12
                      )
                    ),
                    trailing: Text(
                      getDynamicDateString(notif.timeStamp),
                      style: TextStyle(
                        color: isRead ? Colors.black54 : Colors.black87,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12
                      )
                    ),
                    horizontalTitleGap: 5,
                    selected: true,
                    selectedColor: Colors.green,
                    onTap: () {
                      context.read<NotificationsBloc>().add(NotificationsUpdateIsRead(notif.keyId ?? ''));
                      context.read<AppBloc>().add(AppNotificationArgsPassed(notif.keyId ?? ''));
                      context.flow<AppStatus>().update((state) => AppStatus.notificationViewer);
                    }
                  )
                );
              }
            )
          );
        }
        if (state.status.isError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w700
              )
            )
          );
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}