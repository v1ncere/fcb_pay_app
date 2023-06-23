import 'package:flutter/material.dart';

class SignInText extends StatelessWidget {
  const SignInText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Sign In',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: Color(0xFF009405),
      ),
    );
  }
}