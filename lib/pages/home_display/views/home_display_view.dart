import 'package:fcb_pay_app/global_widgets/custom_widgets/container_body.dart';
import 'package:fcb_pay_app/pages/home_display/home_display.dart';
import 'package:flutter/material.dart';

class HomeDisplayView extends StatelessWidget {
  const HomeDisplayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Header(),
            ),
            ContainerBody(
              children: [
                SizedBox(height: 10),
                CardHomeDisplay(),
              ]
            )
          ],
        ),
      ),
    );
  }
}