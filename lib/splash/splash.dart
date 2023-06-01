import 'dart:async';

import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  static Page<void> page() => const MaterialPage<void>(child: Splash());

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
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
      key: key,
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Text("Where Quality Service is a Commitment.", style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic, fontFamily: 'Open Sans'))
              )
            ]
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/fcb-logo.png', width: animation.value * 250, height: animation.value * 250)
            ]
          ),
        ],
      ),
    );
  }

  Future<Timer> startTime() async {
    Duration duration = const Duration(seconds: 2);
    return Timer(duration, navigationPage);
  }

  void navigationPage() {
    if (key.currentContext != null) {
      final appBloc = BlocProvider.of<AppBloc>(key.currentContext!);
      final appStatus = appBloc.state.status;
      key.currentContext!.flow<AppStatus>().update((state) => appStatus);
    }
  }
}