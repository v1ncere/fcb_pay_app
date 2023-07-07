import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/register/register.dart';

class StepperNextButton extends StatelessWidget {
  const StepperNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('stepper_next_elevated_button'),
      style: ElevatedButton.styleFrom(elevation: 0),
      onPressed: () => context.read<RegisterStepperCubit>().stepContinued(),
      child: const Text('NEXT')
    );
  }
}