import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/app/app.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Actions',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w700
              )
            ),
            const Divider(color: Colors.black),
            const SizedBox(height: 10),
            Row(
              children: [
                _CircleButton(
                  icon: FontAwesomeIcons.wallet,
                  color: Colors.greenAccent,
                  text: 'Fund Transfer',
                  function: () => context.flow<AppStatus>().update((state) => AppStatus.accountFundTransfer)
                ),
                const SizedBox(width: 20),
                _CircleButton(
                  icon: FontAwesomeIcons.receipt,
                  color: Colors.yellow,
                  text: 'Pay Bills',
                  function: () => context.flow<AppStatus>().update((state) => AppStatus.accountPayment)
                )
              ]
            )
          ]
        )
      )
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.icon,
    required this.text,
    required this.color,
    required this.function
  });
  final IconData icon;
  final String text;
  final Color color;
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Material(
            elevation: 4,
            color: const Color(0xFF25C166),
            child: InkWell(
              splashColor: Colors.white60,
              onTap: function,
              child: SizedBox(
                width: 56,
                height: 56, 
                child: Icon(icon, color: color)
              )
            )
          )
        ),
        Text(text, 
          style: const TextStyle(
            color: Colors.green,
            fontSize: 12,
            fontWeight: FontWeight.w700
          )
        )
      ]
    );
  }
}