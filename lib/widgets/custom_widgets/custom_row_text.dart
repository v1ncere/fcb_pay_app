import 'package:flutter/material.dart';

class CustomRowText extends StatelessWidget {
  const CustomRowText({
    super.key,
    required this.title,
    this.titleColor,
    this.titleFontSize,
    this.titleFontWeight,
    required this.content,
    this.contentColor,
    this.contentFontSize,
    this.contentFontWeight,
  });
  final String title;
  final Color? titleColor;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final String content;
  final Color? contentColor;
  final double? contentFontSize;
  final FontWeight? contentFontWeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: Text(
            title,
            style: TextStyle(
              color: titleColor ?? Colors.black54,
              fontSize: titleFontSize,
              fontWeight: titleFontWeight ?? FontWeight.w600,
              shadows: <Shadow>[
                Shadow(
                  color: Colors.black.withOpacity(0.15), // Shadow color
                  blurRadius: 1,
                  offset: const Offset(0, 1)
                )
              ]
            )
          )
        ),
        Flexible(
          child: Text(
            content,
            style: TextStyle(
              color: contentColor,
              fontSize: contentFontSize,
              fontWeight: contentFontWeight ?? FontWeight.w800,
              shadows: <Shadow>[
                Shadow(
                  color: Colors.black.withOpacity(0.15), // Shadow color
                  blurRadius: 1,
                  offset: const Offset(0, 1)
                )
              ]
            )
          )
        )
      ]
    );
  }
}