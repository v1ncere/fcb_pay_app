import 'package:flutter/material.dart';

import 'package:fcb_pay_app/pages/register/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class RegisterAccountNumberView extends StatelessWidget {
  const RegisterAccountNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            AccountNumberInput(numberSeparatorFormatter: NumberSeparatorFormatter()),
            const SizedBox(height: 12.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                StepperCancelButton(),
                SizedBox(width: 10),
                StepperNextButton(),
              ]
            )
          ]
        )
      )
    );
  }
}