import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/home/widgets/widgets.dart';

class CardButtonMenu extends StatelessWidget {
  const CardButtonMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardButton(
                icon: FontAwesomeIcons.receipt,
                text: "Pay Bills",
                colors:const Color(0xFF25C166),
                function: () => context.flow<AppStatus>().update((next) => AppStatus.payment),
              ),
              CardButton(
                icon: FontAwesomeIcons.moneyBillTransfer,
                text: "Fund Transfer",
                colors:const Color(0xFF00BFA5),
                function: () => context.flow<AppStatus>().update((next) => AppStatus.fundTransfer),
              ),
              CardButton(
                icon: FontAwesomeIcons.pesoSign,
                text: "PESOnet Transfer",
                colors:Colors.teal,
                function: () {}
              )
            ]
          )
        ]
      )
    );
  }
}