import 'package:flutter/material.dart';

import 'package:fcb_pay_app/app/bloc/app_bloc.dart';
import 'package:fcb_pay_app/pages/bottom_appbar_payment/widgets/widgets.dart';
import 'package:fcb_pay_app/pages/payment/payment.dart';

class PaymentSelectionView extends StatelessWidget {
  const PaymentSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaymentCustomText(text: 'Account'),
        AccountDisplayText(),
        SizedBox(height: 15),
        PaymentCustomText(text: 'Select Institution'),
        PaymentInstitutionDropdown(),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StepperNextButton(),
            SizedBox(width: 10,),
            StepperCancelButton(status: AppStatus.accounts)
          ]
        ),
      ]
    );
  }
}