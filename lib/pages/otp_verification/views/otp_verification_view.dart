import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:pinput/pinput.dart';

import '../../../app/app.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../otp_verification.dart';

class OTPVerificationView extends StatelessWidget {
  const OTPVerificationView({super.key, required this.phone});
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<OtpVerificationBloc, OtpVerificationState>(
          listener: (context, state) {
            if (state.status.isFailure) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(customSnackBar(
                text: state.message,
                icon: FontAwesomeIcons.triangleExclamation,
                backgroundColor: ColorString.guardsmanRed,
                foregroundColor: ColorString.mystic,
              ));
            }
            if(state.status.isSuccess) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(customSnackBar(
                text: state.message,
                icon: FontAwesomeIcons.triangleExclamation,
                backgroundColor: ColorString.eucalyptus,
                foregroundColor: ColorString.mystic,
              ));
              context.flow<AppStatus>().update((state) => AppStatus.unauthenticated);
            }
          },
          child: Center(
            child: Padding(
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
                      child: Image.asset(
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
                        ),
                      ),
                      onCompleted: (value) => context.read<OtpVerificationBloc>().add(OTPPinChanged(value))
                    ),
                    const SizedBox(height: 25),
                    BlocBuilder<OtpVerificationBloc, OtpVerificationState>(
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
                                  ? () => context.read<OtpVerificationBloc>().add(OTPVerified(smsCode: state.pin.value, verificationId: state.verificationId))
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
                ),
              )
            )
          )
        )
      )
    );
  }
}