import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

import 'package:fcb_pay_app/app/app.dart';

class StepperCancelButton extends StatelessWidget {
  const StepperCancelButton({super.key, required this.status});
  final AppStatus status;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('account_cancel_elevated_button'),
      onPressed: () => context.flow<AppStatus>().update((state) => status),
      child: const Text('CANCEL'),
    );
  }
}