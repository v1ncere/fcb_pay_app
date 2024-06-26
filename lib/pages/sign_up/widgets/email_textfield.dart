import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import '../sign_up.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your email here', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 10),
            TextFormField(
              controller: state.emailController,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => context.read<SignUpBloc>().add(EmailChanged(value)),
              decoration: InputDecoration(
                filled: true,
                border: const UnderlineInputBorder(),
                label: const Text('Email'),
                hintText: 'example@gmail.com',
                errorText: state.email.displayError?.text(),
                suffixIcon: !state.email.isPure
                ? IconButton(
                    icon: const Icon(FontAwesomeIcons.xmark),
                    iconSize: 18,
                    onPressed: () => context.read<SignUpBloc>().add(EmailTextErased())
                  )
                : null,
              ),
              style: const TextStyle(height: 1.5),
            )
          ]
        );
      }
    );
  }
}