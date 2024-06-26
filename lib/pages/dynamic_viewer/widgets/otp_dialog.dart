import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../utils/utils.dart';
import '../bloc/widgets_bloc.dart';

Dialog otpDialog(BuildContext context) {
  return Dialog(
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Verification',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter the OTP send to your phone number',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black38,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Pinput(
              length: 6,
              showCursor: true,
              defaultPinTheme: PinTheme(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green.shade200),
                ),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )
              ),
              onCompleted: (value) {},
              closeKeyboardWhenCompleted: true,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                backgroundColor: WidgetStatePropertyAll(ColorString.eucalyptus)
              ),
              onPressed: () => context.read<WidgetsBloc>().add(OtpVerified()),
              child: Text(
                'SUBMIT',
                style: TextStyle(
                  color: ColorString.white
                )
              )
            ),
            const SizedBox(height: 25),
            const Text(
              "Didn't receive any code?",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              )
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => context.read<WidgetsBloc>().add(PhoneNumberResent()),
              child: Text(
                'Resend New Code',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorString.jewel
                )
              )
            )
          ]
        ),
      ),
    )
  );
}