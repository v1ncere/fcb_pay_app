import 'package:fcb_pay_app/ui/register/form_inputs/bloc/inputs_bloc.dart';
import 'package:fcb_pay_app/ui/register/stepper/cubit/stepper_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class AccountForm extends StatelessWidget {
  const AccountForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          key: const Key('account_emailInput_textField'),
          onChanged: (value) => context.read<InputsBloc>().add(EmailChanged(value)),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Email',
            errorText: state.email.invalid ? state.email.error?.message : null,
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
          key: const Key('account_passwordInput_textField'),
          onChanged: (value) => context.read<InputsBloc>().add(PasswordChanged(value)),
          obscureText: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Password',
            errorText: state.password.invalid ? state.password.error?.message : null,
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
          key: const Key('account_confirmPasswordInput_textField'),
          onChanged: (value) => context.read<InputsBloc>().add(ConfirmedPasswordChanged(state.password.value, value)),
          obscureText: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Password',
            errorText: state.confirmedPassword.invalid ? state.confirmedPassword.error?.message : null,
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
          key: const Key('accountForm_submitButton_elevatedButton'),
          style: ElevatedButton.styleFrom(elevation: 0),
          onPressed: state.status.isValidated
            ? context.read<StepperCubit>().stepContinued
            : null,
          child: const Text('SUBMIT'),
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
          key: const Key('accountForm_cancelButton_elevatedButton'),
          onPressed: () => context.read<StepperCubit>().stepCancelled,
          child: const Text('CANCEL'),
        );
      },
    );
  }
}
