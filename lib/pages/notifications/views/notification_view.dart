import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../app/app.dart';
import '../../../widgets/widgets.dart';
import '../../home_flow/home_flow.dart';
import '../widgets/widgets.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InactivityDetector(
        onInactive: () => context.flow<HomeRouterStatus>().complete(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Notifications',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w700
              )
            ),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () => context.flow<HomeRouterStatus>().update((state) => HomeRouterStatus.appBar), 
                icon: const Icon(FontAwesomeIcons.x, size: 18)
              )
            ]
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
      )
    );
  }
}