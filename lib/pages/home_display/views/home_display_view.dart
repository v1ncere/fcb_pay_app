import 'package:fcb_pay_app/global_widgets/custom_widgets/container_body.dart';
import 'package:fcb_pay_app/pages/home_display/home_display.dart';
import 'package:flutter/material.dart';

class HomeDisplayView extends StatelessWidget {
  const HomeDisplayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: const [
              Header(),
              SizedBox(height: 20.0),
              ContainerBody(
                children: [
                  CardHomeDisplay(),
                  SizedBox(height: 20.0),
                  CardButtonMenu(),
                  SizedBox(height: 20.0),
                ]
              )
            ],
          ),
        ),
      ),
    );
  }
}