import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';

class StepperCancelButton extends StatelessWidget {
  const StepperCancelButton({
    super.key,
    this.status
  });
  final AppStatus? status;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('ft_cancel_text_button'),
      onPressed: () => status != null
        ? context.flow<AppStatus>().update((state) => status!)
        : context.read<FundTransferStepperCubit>().stepCancelled(),
      child: const Text(
        'Cancel',
        style: TextStyle(
          color: Colors.green
        )
      )
    );
  }
}