import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/bottom_appbar_payment/bottom_appbar_payment.dart';
import 'package:fcb_pay_app/pages/payment/payment.dart';

class PaymentStepperView extends StatelessWidget {
  const PaymentStepperView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentStepperCubit, PaymentStepperState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Payment',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
            body: Stepper(
              type: StepperType.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              currentStep: state.currentStep,
              onStepTapped: context.read<PaymentStepperCubit>().stepTapped,
              controlsBuilder: (context, details) => const SizedBox.shrink(),
              steps: getSteps(state.currentStep),
            )
          ),
        );
      },
    );
  }

  List<Step> getSteps(int currentStep) {
    return <Step> [
      Step(
        title: const Text('Payment Selection'),
        content: const PaymentSelectionView(),
        isActive: currentStep >= 0,
        state: currentStep >= 0
          ? StepState.complete
          : StepState.disabled
      ),
      Step(
        title: const Text('Input Amount'),
        content: const PaymentSubmissionView(),
        isActive: currentStep >= 1,
        state: currentStep >= 1
          ? StepState.complete
          : StepState.disabled,
      ),
    ];
  }
}