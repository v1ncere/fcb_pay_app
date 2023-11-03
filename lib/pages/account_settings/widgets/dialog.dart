import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

Widget errorDialog = const Dialog(
  shape: CircleBorder(side: BorderSide()),
  child: SizedBox(
    height: 300.0,
    width: 300.0,
    child: Center(
      child: RiveAnimation.asset('assets/error.riv')
    )
  )
);

Widget successDialog = Dialog(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
  child: const SizedBox(
    height: 300.0,
    width: 300.0,
    child: Center(
      child: RiveAnimation.asset('assets/success.riv')
    )
  )
);