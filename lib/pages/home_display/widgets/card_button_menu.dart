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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardButton(iconData: UniconsLine.user_plus, text: "Add Account", colors:const Color.fromARGB(255, 0, 183, 255), function: () => Navigator.of(context).pushNamed('/add_account')),
              CardButton(iconData: UniconsLine.user_minus, text: "Delete Account", colors:const Color(0xFFF73232), function: () => Navigator.of(context).pushNamed('/delete_account')),
              CardButton(iconData: UniconsLine.exchange_alt, text: "Transfer to Pitakard", colors:const Color.fromARGB(255, 221, 144, 0), function: () => Navigator.of(context).pushNamed('/add_account')),
              CardButton(iconData: UniconsLine.history_alt, text: "History", colors:const Color(0xFFDBD80B), function: () => Navigator.of(context).pushNamed('/add_account')),
          ]),
          const SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardButton(iconData: UniconsLine.qrcode_scan, text: "QR Pay", colors:const Color(0xFF02AE08), function: () => Navigator.of(context).pushNamed('/add_account')),
              CardButton(iconData: UniconsLine.bill, text: "Bills Payment", colors:const Color(0xFF02AE08), function: () => Navigator.of(context).pushNamed('/add_account')),
              CardButton(iconData: UniconsLine.transaction, text: "Fund Transfer", colors:const Color(0xFF02AE08), function: () => Navigator.of(context).pushNamed('/add_account')),
              CardButton(iconData: UniconsLine.money_insert, text: "PESOnet Transfer", colors:const Color(0xFF02AE08), function: () => Navigator.of(context).pushNamed('/add_account')),
          ]),
      ]),
    );
  }
}