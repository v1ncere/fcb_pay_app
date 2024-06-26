import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';

class DynamicViewerShimmer extends StatelessWidget {
  const DynamicViewerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (var i = 0; i < 3; i++) {
      widgets.add(const ShimmerRectLoading());
      if(i < 2) {
        widgets.add(const SizedBox(height: 10));
      }
    }
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, left: 15.0),
      child: CustomCardContainer(
        color: const Color(0xFFFFFFFF),
        children: widgets.toList(),
      )
    );
  }
}