import 'package:flutter/material.dart';

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
            child: Text('HEADER') // < =====
          ),
          ContainerBody( // custom ListView container with design
            children: [
              SizedBox(height: 15),
              Text('CAROUSEL'), // < =====
              SizedBox(height: 50),
              Text('CUSTOM BUTTON') // < ===== 
            ]
          )
        ]
      )
    );
  }
}