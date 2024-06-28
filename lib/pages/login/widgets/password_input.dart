import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import '../../../utils/utils.dart';
import '../login.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) => context.read<LoginBloc>().add(LoginPasswordChanged(value)),
          obscureText: state.isObscure,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(30, 37, 193, 102),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(FontAwesomeIcons.unlockKeyhole, color: ColorString.eucalyptus),
            labelText: 'Password',
            errorText: state.password.displayError?.text(),
            border: SelectedInputBorderWithShadow(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none
            ),
            suffixIcon: IconButton(
              onPressed: () => context.read<LoginBloc>().add(LoginPasswordObscured()), 
              icon: Icon(
                state.isObscure 
                ? FontAwesomeIcons.eye 
                : FontAwesomeIcons.eyeSlash,
                color: Colors.black12,
              )
            )
          )
        );
      }
    );
  }
}