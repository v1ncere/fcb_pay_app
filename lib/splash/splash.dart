import 'dart:async';

import 'package:fcb_pay_app/app/app.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  bool _visible = true;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation.addListener(() => setState(() {}));
    animationController.forward();
    setState(() { _visible = !_visible; });
    startTime();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Text("Where Quality Service is a Commitment.", 
                  style: TextStyle(color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Open Sans'
                  )
                )
              )
            ]
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/fcb-logo.png',
                width: animation.value * 250,
                height: animation.value * 250
              )
            ]
          )
        ]
      )
    );
  }

  Future<Timer> startTime() async {
    return Timer(const Duration(seconds: 3), () async {
      await Navigator.of(context).pushAndRemoveUntil(App.route(), (route) => false);
      if (!mounted) return;
    });
  }
}