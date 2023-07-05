import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';
import 'package:fcb_pay_app/pages/fund_transfer/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class FundTransferAmountView extends StatelessWidget {
  const FundTransferAmountView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomizedText(text: "Amount", color: Colors.black54),
          const SizedBox(height: 5),
          const AmountTextField(),
          const SizedBox(height: 30),
          const CustomizedText(text: "Message (optional):", color: Colors.black54),
          const SizedBox(height: 5),
          const MessageTextField(),
          const SizedBox(height: 5),
          const Divider(thickness: 2),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const StepperCancelButton(),
              const SizedBox(width: 10),
              StepperNextButton(function: () => context.read<FundTransferStepperCubit>().stepContinued())
            ]
          )
        ]
      )
    );
  }
}