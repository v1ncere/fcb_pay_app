import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/account_fund_transfer/account_fund_transfer.dart';
import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';

class AccountFundTransferStepperView extends StatelessWidget {
  const AccountFundTransferStepperView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FundTransferStepperCubit, FundTransferStepperState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Fund Transfer",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w700
                )
              )
            ),
            body: Stepper(
              type: StepperType.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              currentStep: state.currentStep,
              onStepTapped: context.read<FundTransferStepperCubit>().stepTapped,
              controlsBuilder: (context, details) => const SizedBox.shrink(),
              steps: _getSteps(state.currentStep)
            )
          )
        );
      }
    );
  }

  List<Step> _getSteps(int currentStep) {
    return <Step> [
      Step(
        title: currentStep == 0 ? const Text('Select') : const Text(''),
        content: const AccountFundTransferSelectView(),
        isActive: currentStep >= 0,
        state: currentStep >= 0
          ? StepState.complete
          : StepState.disabled
      ),
      Step(
        title: currentStep == 1 ? const Text('Amount') : const Text(''),
        content: const AccountFundTransferAmountView(),
        isActive: currentStep >= 1,
        state: currentStep >= 1
          ? StepState.complete
          : StepState.disabled
      ),
      Step(
        title: currentStep == 2 ? const Text('Confirm') : const Text(''),
        content: const AccountFundTransferConfirmView(),
        isActive: currentStep >= 2,
        state: currentStep >= 2
          ? StepState.complete
          : StepState.disabled
      )
    ];
  }
}