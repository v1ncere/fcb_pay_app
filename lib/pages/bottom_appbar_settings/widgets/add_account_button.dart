import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/bottom_appbar_settings/widgets/widgets.dart';

class AddAccountButton extends StatelessWidget {
  const AddAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 45,
            width: 110,
            child: AddAccountCard(
              colors: Colors.green,
              icon: FontAwesomeIcons.piggyBank,
              text: "ADD ACCOUNT",
              function: () => context.flow<AppStatus>().update((state) => AppStatus.addAccount)
            )
          )
        ]
      )
    );
  }
}