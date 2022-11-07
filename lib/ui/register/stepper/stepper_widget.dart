import 'package:fcb_pay_app/ui/register/stepper/cubit/stepper_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        content: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: TextFormField(decoration: const InputDecoration(labelText: 'Email Address', border: OutlineInputBorder())),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: TextFormField(decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder())),
            ),
          ],
        ),
        isActive: currentStep >= 0,
        state: currentStep >= 0 ? StepState.complete : StepState.disabled
      ),
      Step(
        title: const Text('Address'),
        content: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Home Address', border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Postcode', border: OutlineInputBorder()),
              ),
            ),
          ],
        ),
        isActive: currentStep >= 1,
        state: currentStep >= 1 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text('Mobile Number'),
        content: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Mobile Number', border: OutlineInputBorder()),
              ),
            ),
          ],
        ),
        isActive: currentStep >= 2,
        state: currentStep >= 2 ? StepState.complete : StepState.disabled,
      ),
    ];
  }
}