import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
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
        fontSize: fontSize,
        shadows: <Shadow>[
          Shadow(
            color: Colors.black.withOpacity(0.15), // Shadow color
            blurRadius: 1,
            offset: const Offset(0, 1)
          )
        ]
      )
    );
  }
}