import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/login/login.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('login_password_input_textfield'),
          onChanged: (password) => context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(30, 37, 193, 102),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: const Icon(FontAwesomeIcons.unlockKeyhole),
            labelText: 'Password',
            errorText: state.password.displayError?.text(),
            border: SelectedInputBorderWithShadow(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none
            )
          )
        );
      }
    );
  }
}