import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordChecker extends StatelessWidget {
  const PasswordChecker({
    super.key,
    required this.text,
    required this.color,
  });
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          FontAwesomeIcons.solidCircleCheck,
          color: color,
          size: 10,
        ),
        const SizedBox(width: 3),
        Text(
          text,
          style: TextStyle(
            color: color
          )
        )
      ]
    );
  }
}