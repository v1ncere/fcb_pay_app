import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/register/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/number_separator_formatter.dart';

class AccountNumberForm extends StatelessWidget {
  const AccountNumberForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _AccountNumberInput(),
            const SizedBox(height: 12.0),
            Row(
              children: [
                _SubmitButton(),
                const SizedBox(width: 8.0),
                _CancelButton(),
              ],
            )
          ]
        ),
      ),
    );
  }
}

class _AccountNumberInput extends StatelessWidget {
  final NumberSeparatorFormatter _numberSeparatorFormatter = NumberSeparatorFormatter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputsBloc, InputsState>(
      buildWhen: (previous, current) => previous.accountNumber != current.accountNumber,
      builder: (context, state) {
        return TextField(
          key: const Key('account_number_textfield'),
          inputFormatters: [_numberSeparatorFormatter],
          onChanged: (account) => context.read<InputsBloc>().add(AccountNumberChanged(account)),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Account Number',
            errorText: state.accountNumber.displayError?.text(),
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
          key: const Key('account_number_submit_elevated_button'),
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
          key: const Key('account_number_cancel_elevated_button'),
          onPressed: context.read<StepperCubit>().stepCancelled,
          child: const Text('BACK'),
        );
      },
    );
  }
}