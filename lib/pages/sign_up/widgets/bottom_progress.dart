import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../utils/utils.dart';

class BottomProgress extends StatelessWidget {
  const BottomProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SpinKitThreeBounce(
            size: 18,
            color: ColorString.eucalyptus,
          )
        ]
      )
    );
  }
}