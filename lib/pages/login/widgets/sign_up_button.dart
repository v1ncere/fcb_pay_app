import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () => Navigator.of(context).pushNamed('/register'),
      child: const Text(
        'CREATE ACCOUNT',
        style: TextStyle(color: Color(0xFF009405)),
      )
    );
  }
}