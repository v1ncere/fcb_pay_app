import 'package:fcb_pay_app/pages/bottom_appbar/widgets/widgets.dart';
import 'package:fcb_pay_app/pages/home_flow/home_flow.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

import 'package:fcb_pay_app/pages/notifications/widgets/widgets.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Notifications',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w700
            )
          )
        ),
        body: InactivityDetector(
          onInactive: () {
            context.flow<HomePageStatus>().complete();
          },
          child: const Column(
            children: [
              SizedBox(height: 10),
              ContainerBody(
                children: [
                  NotificationList()
                ]
              )
            ]
          ),
        )
      )
    );
  }
}