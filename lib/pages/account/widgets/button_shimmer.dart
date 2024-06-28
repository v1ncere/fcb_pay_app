import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ButtonShimmer extends StatelessWidget {
  const ButtonShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10
      ),
      shrinkWrap: true,
      itemCount: 7,
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 224, 224, 224), 
          highlightColor: const Color.fromARGB(255, 245, 245, 245),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey
            )
          )
        );
      }
    );
  }
}