import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/bottom_appbar_payment/bottom_appbar_payment.dart';

class StepperNextButton extends StatelessWidget {
  const StepperNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: context.read<PaymentStepperCubit>().stepContinued,
      child: const Text('Next'),
    );
  }
}