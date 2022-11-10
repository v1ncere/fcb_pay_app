import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/ui/register/form_inputs/account/account_barrel.dart';
import 'package:fcb_pay_app/ui/register/form_inputs/address/view/view_barrel.dart';
import 'package:fcb_pay_app/ui/register/form_inputs/mobile_number/mobile_number_barrel.dart';
import 'package:fcb_pay_app/ui/register/stepper/cubit/stepper_cubit.dart';

class StepperWidget extends StatelessWidget {
  const StepperWidget({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepperCubit, StepperState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: Stepper(
              type: StepperType.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              currentStep: state.currentStep,
              onStepTapped: context.read<StepperCubit>().stepTapped,
              controlsBuilder: (context, details) {
                return const SizedBox.shrink();
              },
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
        title: const Text('Account'),
        content: const AccountPage(),
        isActive: currentStep >= 0,
        state: currentStep >= 0 ? StepState.complete : StepState.disabled
      ),
      Step(
        title: const Text('Address'),
        content: const AddressPage(),
        isActive: currentStep >= 1,
        state: currentStep >= 1 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text('Mobile Number'),
        content: const MobileNumberPage(),
        isActive: currentStep >= 2,
        state: currentStep >= 2 ? StepState.complete : StepState.disabled,
      ),
    ];
  }
}