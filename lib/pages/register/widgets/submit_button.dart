import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/pages/register/register.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.status != current.status || current.isValid,
      builder: (context, state) {
        return state.status.isInProgress
        ? const CircularProgressIndicator()
        : ElevatedButton(
          key: const Key('register_submit_elevated_button'),
          style: ElevatedButton.styleFrom(elevation: 0),
          onPressed: state.isValid
          ? () => context.read<RegisterBloc>().add(FormSubmitted())
          : null,
          child: const Text('SUBMIT')
        );
      }
    );
  }
}