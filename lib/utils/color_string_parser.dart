import 'package:flutter/material.dart';

Color colorStringParser(String colorString) {
  // regex to match both '0x' and '#' then replace with '' empty string
  String hexColor = colorString.trim().replaceAll(RegExp(r'(?:#|0x)'), '');
  
  if (hexColor.length == 6) {
    hexColor = 'FF$hexColor'; // Add 'FF' for fully opaque color
  } // In Flutter, the Color class represents colors in the ARGB format

  return Color(int.parse(hexColor, radix: 16));
}