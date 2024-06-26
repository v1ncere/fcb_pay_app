import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import '../sign_up.dart';

class ConfirmPasswordTextField extends StatelessWidget {
  const ConfirmPasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Confirm your password', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 10),
            TextFormField(
              controller: state.confirmPasswordController,
              obscureText: state.obscureConfirmPassword,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                filled: true,
                border: const UnderlineInputBorder(),
                label: const Text('Confirm Password'),
                errorText: state.confirmPassword.displayError?.text(),
                suffixIcon: !state.confirmPassword.isPure
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: state.obscureConfirmPassword 
                        ? const Icon(FontAwesomeIcons.eye)
                        : const Icon(FontAwesomeIcons.eyeSlash),
                        iconSize: 18,
                        onPressed: () => context.read<SignUpBloc>().add(ConfirmPasswordObscured()),
                      ),
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.xmark),
                        iconSize: 18,
                        onPressed: () => context.read<SignUpBloc>().add(ConfirmPasswordTextErased())
                      )
                    ]
                  )
                : null 
              ),
              onChanged: (value) => context.read<SignUpBloc>().add(ConfirmPasswordChanged(confirmPassword: value, password: state.password.value)),
            )
          ]
        );
      }
    );
  }
}