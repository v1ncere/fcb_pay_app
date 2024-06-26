import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import '../../../utils/utils.dart';
import '../re_authenticate.dart';

class PasswordDialogInput extends StatelessWidget {
  const PasswordDialogInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReAuthBloc, ReAuthState>(
      builder: (context, state) {
        return TextField(
          onChanged: (password) => context.read<ReAuthBloc>().add(ReAuthPasswordChanged(password)),
          obscureText: state.isObscure,
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
            ),
            suffixIcon: IconButton(
              onPressed: () => context.read<ReAuthBloc>().add(ReAuthPasswordObscured()),
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
