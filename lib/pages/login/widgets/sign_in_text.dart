import 'package:flutter/material.dart';

class SignInText extends StatelessWidget {
  const SignInText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Sign In',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF25C166),
        shadows: [
          Shadow(
            blurRadius: 4,
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0.3, 1.5)
          )
        ]
      )
    );
  }
}