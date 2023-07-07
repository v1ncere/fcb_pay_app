import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/register/register.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class MobileNumberInput extends StatelessWidget {
  const MobileNumberInput({
    super.key,
    required this.phoneNumberFormatter
  });
  final PhoneNumberFormatter phoneNumberFormatter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.mobileNumber != current.mobileNumber,
      builder: (context, state) {
        return TextField(
          inputFormatters: [phoneNumberFormatter],
          key: const Key('mobile_number_textfield'),
          onChanged: (value) => context.read<RegisterBloc>().add(MobileNumberChanged(value)),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Mobile number',
            errorText: state.mobileNumber.displayError?.text()
          )
        );
      }
    );
  }
}