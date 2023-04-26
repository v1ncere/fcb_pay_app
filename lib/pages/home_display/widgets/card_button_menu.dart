import 'package:flutter/material.dart';
import 'package:fcb_pay_app/pages/home_display/home_display.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                colors:const Color(0xFFC5B800),
                function: () => Navigator.of(context).pushNamed('/add_account'),
              ),
              CardButton(
                icon: FontAwesomeIcons.creditCard,
                text: "Pitakard Transfer",
                colors:const Color.fromARGB(255, 221, 144, 0),
                function: () => Navigator.of(context).pushNamed('/add_account'),
              ),
              CardButton(
                icon: FontAwesomeIcons.moneyBillTransfer,
                text: "Fund Transfer",
                colors:const Color(0xFFC55123),
                function: () => Navigator.of(context).pushNamed('/add_account'),
              ),
              CardButton(
                icon: FontAwesomeIcons.pesoSign,
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