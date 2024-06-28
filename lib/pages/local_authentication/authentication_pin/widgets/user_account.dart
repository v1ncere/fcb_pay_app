import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAccount extends StatelessWidget {
  const UserAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'user:',
          style: TextStyle(color: Color(0xFF687ea1))
        ),
        Text(
          '${FirebaseAuth.instance.currentUser!.email}',
          style: const TextStyle(
            color: Color(0xFF687ea1),
            fontWeight: FontWeight.w900,
            fontSize: 16
          )
        )
      ]
    );
  }
}