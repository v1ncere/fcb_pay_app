import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import 'package:fcb_pay_app/pages/home_display/home_display.dart';

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
                iconData: UniconsLine.bill,
                text: "Bills Payment",
                colors:const Color(0xFFC5B800),
                function: () => Navigator.of(context).pushNamed('/add_account'),
              ),
              CardButton(
                iconData: UniconsLine.transaction,
                text: "Transfer to Pitakard",
                colors:const Color.fromARGB(255, 221, 144, 0),
                function: () => Navigator.of(context).pushNamed('/add_account'),
              ),
              CardButton(
                iconData: UniconsLine.exchange_alt,
                text: "Fund Transfer",
                colors:const Color(0xFFC55123),
                function: () => Navigator.of(context).pushNamed('/add_account'),
              ),
              CardButton(
                iconData: UniconsLine.coins,
                text: "PESOnet Transfer",
                colors:const Color(0xFF1D99B8),
                function: () => Navigator.of(context).pushNamed('/add_account'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}