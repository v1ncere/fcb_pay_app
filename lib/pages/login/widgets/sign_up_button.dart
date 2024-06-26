import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

import '../../../app/app.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.flow<AppStatus>().update((state) => AppStatus.signupVerify),
      child: Text(
        'CREATE ACCOUNT',
        style: TextStyle(
          color: const Color(0xFF25C166),
          shadows: [
            Shadow(
              blurRadius: 2,
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0.2, 1.0)
            )
          ]
        )
      )
    );
  }
}