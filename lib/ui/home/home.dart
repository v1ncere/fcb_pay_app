import 'package:fcb_pay_app/ui/home/widgets/home_widgets_barrel.dart';
import 'package:fcb_pay_app/ui/widgets/container_body.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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