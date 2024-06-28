import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

SnackBar customSnackBar({
  required String text,
  required IconData icon,
  required Color backgroundColor,
  required Color foregroundColor
}) {
  return SnackBar(
    elevation: 0,
    backgroundColor: backgroundColor,
    duration: const Duration(milliseconds: 5000),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FaIcon(icon, color: foregroundColor),
        const SizedBox(width: 10),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const  EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: TextStyle(color: foregroundColor)
            )
          )
        )
      ]
    )
  );
}