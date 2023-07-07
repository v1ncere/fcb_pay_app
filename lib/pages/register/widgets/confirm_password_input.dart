import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/register/register.dart';

class ConfirmPasswordInput extends StatelessWidget {
  const ConfirmPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('confirm_password_textfield'),
          onChanged: (password) => context.read<RegisterBloc>().add(ConfirmedPasswordChanged(state.password.value, password)),
          obscureText: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Confirm Password',
            errorText: state.confirmedPassword.displayError?.text()
          )
        );
      }
    );
  }
}