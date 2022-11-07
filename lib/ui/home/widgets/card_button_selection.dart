import 'package:fcb_pay_app/ui/home/widgets/card_button_item.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class CardButtonSelection extends StatelessWidget {
  const CardButtonSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              CardButton(iconData: UniconsLine.user_plus, text: "Add Account", colors: Color.fromARGB(255, 0, 183, 255)),
              CardButton(iconData: UniconsLine.user_minus, text: "Delete Account", colors: Color(0xFFF73232)),
              CardButton(iconData: UniconsLine.exchange_alt, text: "Transfer to Pitakard", colors: Color.fromARGB(255, 221, 144, 0)),
              CardButton(iconData: UniconsLine.history_alt, text: "History", colors: Color(0xFFDBD80B)),
          ]),
          const SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              CardButton(iconData: UniconsLine.qrcode_scan, text: "QR Pay", colors: Color(0xFF02AE08)),
              CardButton(iconData: UniconsLine.bill, text: "Bills Payment", colors: Color(0xFF02AE08)),
              CardButton(iconData: UniconsLine.transaction, text: "Fund Transfer", colors: Color(0xFF02AE08)),
              CardButton(iconData: UniconsLine.money_insert, text: "PESOnet Transfer", colors: Color(0xFF02AE08)),
          ]),
      ]),
    );
  }
}