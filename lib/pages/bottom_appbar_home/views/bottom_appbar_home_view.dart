import 'package:flutter/material.dart';

import 'package:fcb_pay_app/pages/bottom_appbar_home/bottom_appbar_home.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class HomeDisplayView extends StatelessWidget {
  const HomeDisplayView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Header()
            ),
            ContainerBody(
              children: [
                SizedBox(height: 10),
                CardHomeDisplay()
              ]
            )
          ]
        )
      )
    );
  }
}