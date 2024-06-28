import 'package:flutter/material.dart';

Widget buildFullscreenImage(String imageAssets) {
  return Image.asset(
    imageAssets,
    fit: BoxFit.cover,
    height: double.infinity,
    width: double.infinity,
    alignment: Alignment.center
  );
}