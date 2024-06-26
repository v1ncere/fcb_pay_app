import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_repository/hive_repository.dart';

import '../app/app.dart';
import '../pages/walk_through/walk_through.dart';
import '../utils/utils.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  static Route<void> route() => MaterialPageRoute(builder: (context) => const Splash());
  
  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  final _hiveRepository = HiveRepository();
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation.addListener(() => setState(() {}));
    animationController.forward();
    setState(() { _visible = !_visible; });
    startTime();
  }

  @override
  void dispose() {
    _hiveRepository.closeOnboardingBox();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    TextString.slogan, 
                    style: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Open Sans'
                    )
                  )
                )
              ]
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetString.splashLogo,
                  width: animation.value * 200,
                  height: animation.value * 200
                )
              ]
            )
          ]
        )
      );
  }

  Future<Timer> startTime() async {
    final isOnboarded = await _hiveRepository.isOnboarded();
    return Timer(const Duration(seconds: 3), () async {
      if (!isOnboarded) {
        _hiveRepository.updateOnboarding(true);
        await Navigator.of(context).pushAndRemoveUntil(WalkThroughPage.route(), (route) => false);
        if (!mounted) return;
      } else {
        await Navigator.of(context).pushAndRemoveUntil(App.route(), (route) => false);
        if (!mounted) return;
      }
    });
  }
}