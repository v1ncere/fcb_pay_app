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
        body: const Column(
          children: [
            SizedBox(height: 10),
            ContainerBody(
              children: [
                NotificationList()
              ]
            )
          ]
        )
      )
    );
  }
}