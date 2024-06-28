import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String description;
  final String buttonLeft;
  final String buttonRight;
  final void Function()? onPressed;

  const CustomAlertDialog({
    super.key,
    this.buttonLeft = 'Cancel',
    this.buttonRight = 'Ok',
    required this.description,
    required this.title,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text(buttonLeft),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(buttonRight),
        )
      ]
    );
  }
}