import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import '../../../utils/utils.dart'; 
import '../login.dart';

class MobileNumberInput extends StatelessWidget {
  const MobileNumberInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          inputFormatters: [LengthLimitingTextInputFormatter(10)],
          keyboardType: TextInputType.phone,
          onChanged: (value) => context.read<LoginBloc>().add(MobileNumberInputChanged(value)),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 211, 243, 224),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(FontAwesomeIcons.phone, color: ColorString.eucalyptus),
            prefix: const Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Text(
                '+63',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                )
              )
            ),
            suffix: GestureDetector(
              onTap: !state.isGetOtpTapped
              ? () => _phoneNumberSent(context, state)
              : () => _phoneResentNumberSent(context, state),
              child: Text(
                !state.isGetOtpTapped
                ? 'GET OTP'
                : 'RESEND OTP',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorString.blazeOrange,
                  fontSize: 14
                )
              )
            ),
            labelText: 'Phone Number',
            errorText: state.mobile.displayError?.text(),
            border: SelectedInputBorderWithShadow(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            )
          )
        );
      }
    );
  }

  _phoneNumberSent(BuildContext context, LoginState state) {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<LoginBloc>().add(PhoneNumberSent('+63${state.mobile.value}'));
  }

  _phoneResentNumberSent(BuildContext context, LoginState state) {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<LoginBloc>().add(PhoneNumberResent('+63${state.mobile.value}'));
  }
}