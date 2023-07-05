import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/register/widgets/widgets.dart';

class AccountForm extends StatelessWidget {
  const AccountForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _EmailInput(),
            const SizedBox(height: 12.0),
            _PasswordInput(),
            const SizedBox(height: 12.0),
            _ConfirmPasswordInput(),
            const SizedBox(height: 12.0),
            Row(
              children: [
                _SubmitButton(),
                const SizedBox(width: 8.0),
                _CancelButton(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputsBloc, InputsState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('email_textfield'),
          onChanged: (email) => context.read<InputsBloc>().add(EmailChanged(email)),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Email',
            errorText: state.email.displayError?.text(),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputsBloc, InputsState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('password_textfield'),
          onChanged: (password) => context.read<InputsBloc>().add(PasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Password',
            errorText: state.password.displayError?.text(),
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputsBloc, InputsState>(
      buildWhen: (previous, current) => previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('confirm_password_textfield'),
          onChanged: (password) => context.read<InputsBloc>().add(ConfirmedPasswordChanged(state.password.value, password)),
          obscureText: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Confirm Password',
            errorText: state.confirmedPassword.displayError?.text(),
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputsBloc, InputsState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('account_submit_elevated_button'),
          style: ElevatedButton.styleFrom(elevation: 0),
          onPressed: context.read<StepperCubit>().stepContinued,
          child: const Text('NEXT'),
        );
      },
    );
  }
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputsBloc, InputsState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return TextButton(
          key: const Key('account_cancel_elevated_button'),
          onPressed: () => Navigator.of(context).pushReplacementNamed('/login'),
          child: const Text('CANCEL'),
        );
      },
    );
  }
}
