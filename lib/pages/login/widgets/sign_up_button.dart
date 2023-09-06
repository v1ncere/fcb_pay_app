import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

import 'package:fcb_pay_app/app/app.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('login_sign_up_text_button'),
      onPressed: () => context.flow<AppStatus>().update((state) => AppStatus.register),
      child: const Text(
        'CREATE ACCOUNT',
        style: TextStyle(
          color: Color(0xFF25C166)
        )
      )
    );
  }
}