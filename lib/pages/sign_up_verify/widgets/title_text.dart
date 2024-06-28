import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FCBPay Enrollment',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          'verifying your identity.',
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ] 
    );
  }
}