import 'package:flutter/material.dart';

import 'package:fcb_pay_app/app/bloc/app_bloc.dart';
import 'package:fcb_pay_app/pages/payment/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class PaymentSelectionView extends StatelessWidget {
  const PaymentSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomizedText(
          text: 'Account',
          fontSize: 14,
          color: Colors.green
        ),
        SizedBox(height: 5),
        AccountDropdown(),
        SizedBox(height: 15),
        CustomizedText(
          text: 'Institution',
          fontSize: 14,
          color: Colors.green
        ),
        SizedBox(height: 5),
        InstitutionDropdown(),
        SizedBox(height: 5),
        Divider(thickness: 2),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StepperCancelButton(status: AppStatus.authenticated),
            SizedBox(width: 10),
            StepperNextButton() 
          ]
        )
      ]
    );
  }
}
