import 'package:flutter/material.dart';

import 'package:fcb_pay_app/pages/bottom_appbar_settings/widgets/widgets.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class BottomAppbarSettingsView extends StatelessWidget {
  const BottomAppbarSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleText(),
              LogoutButton()
            ]
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
