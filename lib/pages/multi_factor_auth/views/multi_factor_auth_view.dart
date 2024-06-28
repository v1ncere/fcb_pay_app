import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:pinput/pinput.dart';

import '../../../utils/utils.dart';
import '../bloc/mfa_bloc.dart';
import '../multi_factor_auth.dart';

class MultiFactorAuthView extends StatelessWidget {
  const MultiFactorAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextString.mfaTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.arrow_back),
                )
              ),
              Container(
                width: 200,
                height: 200,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.purple.shade50,
                ),
                child: SvgPicture.asset(
                  'assets/otp.svg' 
                )
              ),
              const SizedBox(height: 20),
              const Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
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
                    border: Border.all(
                      color: Colors.purple.shade200,
                    ),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  )
                ),
                onCompleted: (value) {
                  context.read<MfaBloc>().add(SmsCodeChange(value));
                }
              ),
              const SizedBox(height: 25),
              BlocBuilder<MfaBloc, MfaState>(
                builder: (context, state) {
                  return state.status.isInProgress
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(strokeWidth: 3)
                          )
                        )
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                        onPressed: state.isValid
                        ? () => context.read<MfaBloc>().add(MFAOTPVerified(smsCode: state.smsCode.value, verificationId: state.verificationId))
                        : null,
                        style: ButtonStyle(
                          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                          backgroundColor: WidgetStateProperty.all<Color>(Colors.purple),
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))
                          )
                        ),
                        child: const Text('Verify', style: TextStyle(fontSize: 16)),
                      )
                    );
                }
              ),
              const SizedBox(height: 20),
              const Text(
                "Didn't receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                )
              ),
              const SizedBox(height: 15),
              const Text(
                'Resend New Code', 
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                )
              )
            ]
          )
        )
      ),
    );
  }
}