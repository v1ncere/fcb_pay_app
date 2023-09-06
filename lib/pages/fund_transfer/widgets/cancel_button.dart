import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});
  

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('ft_cancel_text_button'),
      onPressed: () => Navigator.of(context).pop(),
      child: const Text('Cancel',
        style: TextStyle(
          color: Colors.green
        )
      )
    );
  }
}