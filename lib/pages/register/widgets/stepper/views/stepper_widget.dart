import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fcb_pay_app/pages/register/widgets/widgets.dart';

class StepperWidget extends StatelessWidget {
  const StepperWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepperCubit, StepperState> (
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: Stepper(
              type: StepperType.vertical,
              physics: const NeverScrollableScrollPhysics(),
              currentStep: state.currentStep,
              onStepTapped: context.read<StepperCubit>().stepTapped,
              controlsBuilder: (context, details) => const SizedBox.shrink(),
              steps: getSteps(state.currentStep),
            ),
          ),
        );
      },
    );
  }

  List<Step> getSteps(int currentStep) {
    return <Step> [
      Step(
        title: const Text('Email and Password'),
        content: const AccountPage(),
        isActive: currentStep >= 0,
        state: currentStep >= 0
          ? StepState.complete
          : StepState.disabled
      ),
      Step(
        title: const Text('Account Number'),
        content: const AccountNumberPage(),
        isActive: currentStep >= 1,
        state: currentStep >= 1
          ? StepState.complete
          : StepState.disabled,
      ),
      Step(
        title: const Text('Mobile Number'),
        content: const MobileNumberPage(),
        isActive: currentStep >= 2,
        state: currentStep >= 2
          ? StepState.complete
          : StepState.disabled,
      ),
    ];
  }
}