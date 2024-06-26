import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CardError extends StatelessWidget {
  const CardError({
    super.key,
    required this.text
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return CarouselSlider(
      items: [
        Card(
          elevation: 2,
          clipBehavior: Clip.antiAlias,
          color: Colors.grey[200],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: SizedBox(
            height: width,
            width: height,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child:Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w700
                  )
                )
              )
            )
          )
        )
      ],
      options: CarouselOptions(
        initialPage: 0,
        enlargeCenterPage: true,
        enableInfiniteScroll: false
      )
    );
  }
}