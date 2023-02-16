import 'package:flutter/material.dart';

import 'package:fcb_pay_app/ui/home/home.dart';
import 'package:fcb_pay_app/ui/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Column(
        children: const [
          HeaderTitle(name: "Vincent G. Gripo"),
          SizedBox(height: 20.0),
          ContainerBody(
            children: [
              Balance(),
              SizedBox(height: 20.0),
              CardButtonSelection(),
          ]),
      ]),
    );
  }
}