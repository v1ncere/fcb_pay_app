import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/register/register.dart';

class RegisterStepperView extends StatelessWidget {
  const RegisterStepperView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterStepperCubit, RegisterStepperState> (
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Register",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w700
                )
              )
            ),
            body: Stepper(
              type: StepperType.vertical,
              elevation: 0,
              physics: const NeverScrollableScrollPhysics(),
              currentStep: state.currentStep,
              onStepTapped: context.read<RegisterStepperCubit>().stepTapped,
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
        title: const Text('Email & Password'),
        content: const RegisterAccountView(),
        isActive: currentStep >= 0,
        state: currentStep >= 0
          ? StepState.complete
          : StepState.disabled
      ),
      Step(
        title: const Text('Mobile Number'),
        content: const RegisterMobileNumberView(),
        isActive: currentStep >= 1,
        state: currentStep >= 1
          ? StepState.complete
          : StepState.disabled
      )
    ];
  }
}