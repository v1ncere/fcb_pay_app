import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildSVG(String assetName, [double width = 350]) {
  return SvgPicture.asset(assetName, width: width);
}