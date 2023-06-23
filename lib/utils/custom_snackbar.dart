import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

SnackBar customSnackBar(String input, IconData icon, Color color) {
  return SnackBar(
    elevation: 0,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FaIcon(icon, color: color),
        const SizedBox(width: 10),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const  EdgeInsets.only(left: 8.0),
            child: Text(input, style: TextStyle(color: color)),
          ),
        ),
      ],
    ),
  );
}