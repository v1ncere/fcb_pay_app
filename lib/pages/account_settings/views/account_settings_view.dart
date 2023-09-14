import 'package:flutter/material.dart';

import 'package:fcb_pay_app/pages/account_settings/widgets/widgets.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class AccountSettingsView extends StatelessWidget {
  const AccountSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: HeadersCard(),
          ),
          ContainerBody(
            children: [
              AddAccountButton(),
              AccountListViewDisplay()
            ]
          )
        ]
      )
    );
  }
}
