import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/notifications_viewer/notifications_viewer.dart';
import 'package:fcb_pay_app/pages/notifications_viewer/widgets/widgets.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class NotificationsViewerView extends StatelessWidget {
  const NotificationsViewerView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Notification",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w700
            )
          ),
          actions: [
            BlocSelector<AppBloc, AppState, String>(
              selector: (state) => state.args,
              builder: (context, id) {
                return IconButton(
                  icon: const Icon(FontAwesomeIcons.trashCan, color: Color.fromARGB(255, 97, 97, 97)),
                  onPressed: () {
                    context.read<NotificationsViewerBloc>().add(NotificationDelete(id));
                    context.flow<AppStatus>().update((state) => AppStatus.notifications);
                  }
                );
              }
            )
          ]
        ),
        body: const Column(
          children: [
            SizedBox(height: 10),
            ContainerBody(
              children: [
                NotificationDisplay()
              ]
            ),
          ],
        ) 
      ),
    );
  }
}