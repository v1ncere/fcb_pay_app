import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class WalkThroughView extends StatelessWidget {
  const WalkThroughView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: WalkThroughWidget(),
      )
    );
  }
}