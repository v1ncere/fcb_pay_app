import 'package:flutter/material.dart';

class CustomRowTextDisplay extends StatelessWidget {
  const CustomRowTextDisplay({
    super.key,
    required this.title,
    required this.content,
    this.titleFontWeight,
    this.contentFontWeight,
    this.titleFontSize,
    this.contentFontSize,
    this.color
  });
  final String title;
  final String content;
  final double? titleFontSize;
  final double? contentFontSize;
  final FontWeight? titleFontWeight;
  final FontWeight? contentFontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(title,
            style: TextStyle(
              color: Colors.black54,
              fontSize: titleFontSize,
              fontWeight: titleFontWeight ?? FontWeight.w700
            )
          )
        ),
        Flexible(
          child: Text(content, 
            style: TextStyle(
              color: color,
              fontSize: contentFontSize,
              fontWeight: contentFontWeight ?? FontWeight.w800
            )
          )
        )
      ]
    );
  }
}