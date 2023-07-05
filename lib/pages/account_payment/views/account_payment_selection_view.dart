import 'package:flutter/material.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/account_payment/widgets/widgets.dart';
import 'package:fcb_pay_app/pages/payment/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class AccountPaymentSelectionView extends StatelessWidget {
  const AccountPaymentSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomizedText(
          text: "Account",
          color: Colors.green,
          fontSize: 14
        ),
        SizedBox(height: 5),
        AccountDisplayText(),
        SizedBox(height: 40),
        CustomizedText(
          text: "Institution",
          color: Colors.green,
          fontSize: 14
        ),
        SizedBox(height: 5),
        InstitutionDropdown(),
        SizedBox(height: 5),
        Divider(thickness: 2),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StepperCancelButton(status: AppStatus.account),
            SizedBox(width: 10),
            StepperNextButton()
          ]
        )
      ]
    );
  }
}