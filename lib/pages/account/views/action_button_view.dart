import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/account/widgets/widgets.dart';

class ActionButtonView extends StatelessWidget {
  const ActionButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Actions',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w900
            )
          ),
          const Divider(color: Color(0xFF25C166)),
          const SizedBox(height: 10),
          Row(
            children: [
              CircleButtonWithLabel(
                icon: FontAwesomeIcons.receipt,
                color: Colors.yellow,
                text: 'Pay Bills',
                function: () => context.flow<AppStatus>().update((state) => AppStatus.accountPayment)
              ),
              const SizedBox(width: 20),
              CircleButtonWithLabel(
                icon: FontAwesomeIcons.wallet,
                color: Colors.greenAccent,
                text: 'Fund Transfer',
                function: () => context.flow<AppStatus>().update((state) => AppStatus.accountFundTransfer)
              )
            ]
          )
        ]
      )
    );
  }
}