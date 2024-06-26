import 'package:flutter/material.dart';

import '../walk_through.dart';

class WalkThroughPage extends StatelessWidget {
  const WalkThroughPage({super.key});
  static Route<void> route() => MaterialPageRoute(builder: (context) => const WalkThroughPage());
  
  @override
  Widget build(BuildContext context) {
    return  const WalkThroughView();
  }
}
