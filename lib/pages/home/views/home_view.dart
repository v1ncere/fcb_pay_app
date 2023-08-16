import 'package:flutter/material.dart';

import 'package:fcb_pay_app/pages/home/widgets/widgets.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Header()
            ),
            ContainerBody(
              children: [
                SizedBox(height: 15),
                CarouselCardDisplay()
              ]
            )
          ]
        )
      )
    );
  }
}