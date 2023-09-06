import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerRectLoading extends StatelessWidget {
  const ShimmerRectLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        )
      )
    );
  }
}