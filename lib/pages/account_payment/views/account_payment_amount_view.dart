import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/payment/payment.dart';
import 'package:fcb_pay_app/pages/payment/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class AccountPaymentAmountView extends StatelessWidget {
  const AccountPaymentAmountView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomizedText(
          text: "Amount",
          color: Colors.green
        ),
        const SizedBox(height: 5),
        const PaymentAmountTextField(),
        const SizedBox(height: 15),
        const AdditionalTextField(),
        const SizedBox(height: 5),
        const Divider(thickness: 2),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const StepperCancelButton(),
            const SizedBox(width: 10),
            StepperNextButton(function: () => context.read<PaymentBloc>().add(AdditionalFieldDisplayed()))
          ]
        )
      ]
    );
  }
}