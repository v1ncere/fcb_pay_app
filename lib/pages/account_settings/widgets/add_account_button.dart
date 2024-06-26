import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../home_flow/home_flow.dart';
import 'widgets.dart';

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
              colors:const Color(0xFF00BFA5),
              icon: FontAwesomeIcons.piggyBank,
              text: 'ADD ACCOUNT',
              function: () => context.flow<HomeRouterStatus>().update((state) => HomeRouterStatus.addAccount)
            )
          )
        ]
      )
    );
  }
}