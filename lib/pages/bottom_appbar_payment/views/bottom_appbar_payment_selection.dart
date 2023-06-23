import 'package:flutter/material.dart';

import 'package:fcb_pay_app/app/bloc/app_bloc.dart';
import 'package:fcb_pay_app/pages/bottom_appbar_payment/bottom_appbar_payment.dart';

class BottomAppbarPaymentSelection extends StatelessWidget {
  const BottomAppbarPaymentSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaymentCustomText(text: 'Select Institution'),
        PaymentInstitutionDropdown(),
        SizedBox(height: 15),
        PaymentCustomText(text: 'Select Account'),
        PaymentAccountDropdown(),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StepperNextButton(),
            SizedBox(width: 10),
            StepperCancelButton(status: AppStatus.authenticated)
          ]
        )
      ]
    );
  }
}
