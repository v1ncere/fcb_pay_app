import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListTileShimmer extends StatelessWidget {
  const ListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int numberOfTiles = 3;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: numberOfTiles,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
         baseColor: const Color.fromARGB(255, 224, 224, 224),
         highlightColor: const Color.fromARGB(255, 245, 245, 245),
          child: ListTile(
            leading: const CircleAvatar(),
            title: Container(
              width: screenWidth * 0.6,
              height: 16,
              color: Colors.white,
            ),
            subtitle: Container(
              width: screenWidth * 0.5,
              height: 12,
              color: Colors.white,
            ),
            trailing: Container(
              width: screenWidth * 0.1,
              height: double.infinity,
              color: Colors.white,
            )
          )
        );
      }
    );
  }
}