import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:introduction_screen/introduction_screen.dart';

import '../widgets/widgets.dart';
import '/../app/app.dart';
import '/../utils/utils.dart';

class WalkThroughWidget extends StatelessWidget {
  const WalkThroughWidget({super.key});
  static final introKey = GlobalKey<IntroductionScreenState>();
  
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: ColorString.white,
      allowImplicitScrolling: true,
      pages: pageViewModelList(introKey),
      onDone: () async => await Navigator.of(context).pushAndRemoveUntil(App.route(), (route) => false),
      onSkip: () async => await Navigator.of(context).pushAndRemoveUntil(App.route(), (route) => false),
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      back: const Icon(Icons.arrow_back),
      skip: Text('Skip', style: TextStyle(color: ColorString.white)),
      next: Icon(FontAwesomeIcons.arrowRight, color: ColorString.white),
      done: Text('Done', style: TextStyle(color: ColorString.white)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: DotsDecorator(
        activeColor: ColorString.white,
        size: const Size(10.0, 10.0),
        color: ColorString.algaeGreen,
        activeSize: const Size(22.0, 10.0),
        activeShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
      ),
      dotsContainerDecorator: ShapeDecoration(
        color: ColorString.mountainMeadow,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0)))
      )
    );
  }
}