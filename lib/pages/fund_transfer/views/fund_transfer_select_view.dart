import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';
import 'package:fcb_pay_app/pages/fund_transfer/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class FundTransferSelectView extends StatelessWidget {
  const FundTransferSelectView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomizedText(text: "Source:", color: Colors.black54),
          const SizedBox(height: 5),
          const SourceDropdown(),
          const SizedBox(height: 30),
          const CustomizedText(text: "Recipient:", color: Colors.black54),
          const SizedBox(height: 5),
          const RecipientDropdown(),
          const SizedBox(height: 5),
          const Divider(thickness: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const StepperCancelButton(status: AppStatus.authenticated),
              const SizedBox(width: 10),
              StepperNextButton(function: () => context.read<FundTransferStepperCubit>().stepContinued())
            ]
          )
        ]
      )
    );
  }
}