import 'package:flutter/material.dart';

class PaymentCustomText extends StatelessWidget {
  const PaymentCustomText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black38,
        fontWeight: FontWeight.w700
      ),
    );
  }
}