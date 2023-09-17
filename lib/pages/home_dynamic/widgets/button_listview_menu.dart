import 'package:fcb_pay_app/pages/home_dynamic/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';
import 'package:flutter/material.dart';


class CardButtonMenu extends StatelessWidget {
  const CardButtonMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          // return ButtonCard(
          //   colors: '#55B9F4'.toColor(),
          //   icon: ,
          //   function: ,
          //   text: ,
          // );
        },
      )
    );
  }
}