import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import '../../../utils/utils.dart';
import '../sign_up.dart';
import 'widgets.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your password', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 10),
            TextFormField(
              controller: state.passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: state.obscurePassword,
              decoration: InputDecoration(
                filled: true,
                border: const UnderlineInputBorder(),
                label: const Text('Password'),
                errorText: state.password.displayError?.text(),
                suffixIcon: !state.password.isPure
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: state.obscurePassword 
                        ? const Icon(FontAwesomeIcons.eye) 
                        : const Icon(FontAwesomeIcons.eyeSlash),
                        iconSize: 18,
                        onPressed: () => context.read<SignUpBloc>().add(PasswordObscured()),
                      ),
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.xmark),
                        iconSize: 18,
                        onPressed: () => context.read<SignUpBloc>().add(PasswordTextErased())
                      )
                    ],
                  )
                : null
              ),
              onChanged: (value) => context.read<SignUpBloc>().add(PasswordChanged(value)),
            ),
            const SizedBox(height: 5),
            PasswordChecker(
              text: 'Uppercase letters',
              color: _containsUppercase(state.password.value) ? ColorString.deepSea : Colors.black26,
            ),
            PasswordChecker(
              text: 'Numbers',
              color: _containsNumber(state.password.value) ? ColorString.deepSea : Colors.black26
            ),
            PasswordChecker(
              text: 'Special characters',
              color: _containsSpecialChar(state.password.value) ? ColorString.deepSea : Colors.black26
            ),
            PasswordChecker(
              text: 'Minimum of 8 characters',
              color: _isLengthMinimun(state.password.value) ? ColorString.deepSea : Colors.black26
            ),
          ]
        );
      }
    );
  }

  bool _containsUppercase(String value) => value.contains(RegExp(r'[A-Z]'));

  bool _containsNumber(String value) => value.contains(RegExp(r'[0-9]'));

  bool _containsSpecialChar(String value) => value.contains(RegExp(r'[!@#\$%^&*()\-=+_{}\[\];:,.<>?/\\|]'));

  bool _isLengthMinimun(String value) => value.length >= 8;
}