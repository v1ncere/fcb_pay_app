import 'package:flutter/material.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/register/widgets/widgets.dart';

class RegisterAccountView extends StatelessWidget {
  const RegisterAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            EmailInput(),
            SizedBox(height: 12.0),
            PasswordInput(),
            SizedBox(height: 12.0),
            ConfirmPasswordInput(),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                StepperCancelButton(status: AppStatus.unauthenticated),
                SizedBox(width: 10),
                StepperNextButton()
              ]
            )
          ]
        )
      )
    );
  }
}