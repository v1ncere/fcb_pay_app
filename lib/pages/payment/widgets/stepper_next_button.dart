import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/payment/payment.dart';

class StepperNextButton extends StatelessWidget {
  const StepperNextButton({super.key, this.function});
  final Function? function;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.green)
      ),
      onPressed: () {
        function != null ? function!() : null;
        context.read<PaymentStepperCubit>().stepContinued();
      },
      child: const Text('Next')
    );
  }
}