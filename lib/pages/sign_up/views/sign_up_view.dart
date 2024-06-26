import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import '../screens/screens.dart';
import '../sign_up.dart';
import '../widgets/widgets.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpStepperCubit, int>(
      builder: (context, currentStep) { 
        return BlocBuilder<SignUpBloc, SignUpState>(
          builder: (_, signUpState) {
            return LoadingLayer(
              progress: signUpState.progress,
              isLoading: signUpState.otpStatus.isInProgress,
              isProgress: signUpState.formStatus.isInProgress,
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.x, size: 16),
                      onPressed: () => Navigator.of(context).pop()
                    )
                  ]
                ),
                body: Stepper(
                  elevation: 0,
                  currentStep: currentStep,
                  type: StepperType.horizontal,
                  physics: const ScrollPhysics(),
                  steps: getSteps(currentStep, signUpState),
                  onStepTapped: context.read<SignUpStepperCubit>().stepTapped,
                  controlsBuilder: (_, __) => const SizedBox.shrink()
                ),
                bottomNavigationBar: BottomButton(current: currentStep)
              )
            );
          }
        );
      }
    );
  }

  List<Step> getSteps(int step, SignUpState state) {
    const shrink = SizedBox.shrink();
    return <Step>[
      Step(
        title: shrink,
        content: const FirstScreen(),
        isActive: step == 0,
        state: getStepState(0, step, state)
      ),
      Step(
        title: shrink,
        content: const SecondScreen(),
        isActive: step == 1,
        state: getStepState(1, step, state)
      ),
      Step(
        title: shrink,
        content: const ThirdScreen(),
        isActive: step == 2,
        state: getStepState(2, step, state)
      ),
      Step(
        title: shrink,
        content: const FourthScreen(),
        isActive: step == 3,
        state: getStepState(3, step, state)
      )
    ];
  }

  StepState getStepState(int index, int step, SignUpState state) {
    if (step < index) {
      return StepState.disabled;
    } else if (step == index) {
      switch(index) {
        case 0:
          return (state.email.isPure && state.firstName.isPure && state.lastName.isPure && state.mobile.isPure) 
          ? StepState.indexed 
          : StepState.editing;
        case 1:
          return (state.password.isPure && state.confirmPassword.isPure) 
          ? StepState.indexed 
          : StepState.editing;
        case 2:
          return (state.userImage != null) 
          ? StepState.indexed 
          : StepState.editing;
        case 3:
          return StepState.indexed;
        default:
          return StepState.indexed;
      }
    } else {
      switch(index) {
        case 0:
          return (state.email.isValid && state.firstName.isValid && state.lastName.isValid && state.mobile.isValid) 
          ? StepState.complete 
          : StepState.error;
        case 1:
          return (state.password.isValid && state.confirmPassword.isValid) 
          ? StepState.complete
          : StepState.error;
        case 2:
          return (state.userImage != null) 
          ? StepState.complete 
          : StepState.error;
        case 3:
          return StepState.complete;
        default:
          return StepState.error;
      }
    }
  }
}