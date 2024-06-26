import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../receipt.dart';

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
            text: 'Receipt saved successfully',
            icon: FontAwesomeIcons.solidCircleCheck,
            backgroundColor: ColorString.eucalyptus,
            foregroundColor: ColorString.mystic
          ));
        }
        if (state.status.isError) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            text: state.message,
            icon: FontAwesomeIcons.triangleExclamation,
            backgroundColor: ColorString.guardsmanRed,
            foregroundColor: ColorString.mystic
          ));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
          ),
          onPressed: () => context.read<SaveReceiptCubit>().takeScreenshot(globalKey),
          child: const Text('SAVE RECEIPT', style: TextStyle(fontWeight: FontWeight.bold))
        )
      )
    );
  }
}