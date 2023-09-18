import 'package:flutter/material.dart';

import 'package:fcb_pay_app/pages/home_dynamic/widgets/widgets.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class HomeDynamicView extends StatelessWidget {
  const HomeDynamicView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: HeaderCard(),
          ),
          ContainerBody( // custom ListView container with design
            children: [
              SizedBox(height: 15),
              CarouselSliderDisplay(), // < =====
              SizedBox(height: 50),
              CardButtonMenu() // < ===== 
            ]
          )
        ]
      )
    );
  }
}