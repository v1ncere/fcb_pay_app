import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/pages/receipt/cubit/save_receipt_cubit.dart';
import 'package:fcb_pay_app/utils/enums.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class ScreenshotButton extends StatelessWidget {
  const ScreenshotButton({super.key, required this.globalKey});
  final GlobalKey globalKey;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SaveReceiptCubit, SaveReceiptState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            "Receipt saved successfully",
            FontAwesomeIcons.solidCircleCheck,
            Colors.white
          ));
        }
        if (state.status.isError) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            state.message,
            FontAwesomeIcons.triangleExclamation,
            Colors.red
          ));
        }
      },
      child: ElevatedButton(
        onPressed: () => context.read<SaveReceiptCubit>().takeScreenshot(globalKey),
        child: const Text("Save Receipt")
      )
    );
  }
}