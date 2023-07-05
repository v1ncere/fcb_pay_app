import 'package:flutter/material.dart';

class CustomizedText extends StatelessWidget {
  const CustomizedText({
    super.key,
    required this.text,
    required this.color,
    this.fontSize,
    this.fontWeight
  });
  final String text;
  final double? fontSize;
  final Color color;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight ?? FontWeight.w700,
        fontSize: fontSize
      )
    );
  }
}