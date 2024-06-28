import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import '../../../utils/utils.dart';
import '../login.dart';

class OtpInput extends StatelessWidget {
  const OtpInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.otpEnabled
        ? TextFormField(
            inputFormatters: [LengthLimitingTextInputFormatter(6)],
            keyboardType: TextInputType.number,
            onChanged: (value) => context.read<LoginBloc>().add(OtpInputChanged(value)),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 211, 243, 224),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Icon(FontAwesomeIcons.xmarksLines, color: ColorString.eucalyptus),
              suffixIconConstraints: const BoxConstraints(maxHeight: double.infinity),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  state.timerDisplay,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorString.blazeOrange
                  )
                ),
              ),
              labelText: 'OTP',
              errorText: state.otp.displayError?.text(),
              border: SelectedInputBorderWithShadow(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              )
            )
          )
        : const SizedBox.shrink();
      }
    );
  }
}