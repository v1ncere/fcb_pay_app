import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                )
              )
            ),
            body: Stepper(
              type: StepperType.horizontal,
              elevation: 0,
              physics: const NeverScrollableScrollPhysics(),
              currentStep: state.currentStep,
              onStepTapped: context.read<PaymentStepperCubit>().stepTapped,
              controlsBuilder: (context, details) => const SizedBox.shrink(),
              steps: getSteps(state.currentStep)
            )
          )
        );
      }
    );
  }

  List<Step> getSteps(int currentStep) {
    return <Step> [
      Step(
        title: currentStep == 0 ? const Text('Selection') : const Text(""),
        content: const PaymentSelectionView(),
        isActive: currentStep >= 0,
        state: currentStep >= 0
          ? StepState.complete
          : StepState.disabled
      ),
      Step(
        title: currentStep == 1 ? const Text('Amount') : const Text(""),
        content: const PaymentAmountView(),
        isActive: currentStep >= 1,
        state: currentStep >= 1
          ? StepState.complete
          : StepState.disabled
      ),
      Step(
        title: currentStep == 2 ? const Text('Payment') : const Text(""),
        content: const PaymentConfirmView(),
        isActive: currentStep >= 2,
        state: currentStep >= 2
          ? StepState.complete
          : StepState.disabled
      )
    ];
  }
}