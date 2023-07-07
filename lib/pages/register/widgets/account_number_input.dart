import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/register/register.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class AccountNumberInput extends StatelessWidget {
  const AccountNumberInput({super.key, required this.numberSeparatorFormatter});
  final NumberSeparatorFormatter numberSeparatorFormatter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.accountNumber != current.accountNumber,
      builder: (context, state) {
        return TextField(
          key: const Key('account_number_textfield'),
          inputFormatters: [numberSeparatorFormatter],
          onChanged: (account) => context.read<RegisterBloc>().add(AccountNumberChanged(account)),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Account Number',
            errorText: state.accountNumber.displayError?.text()
          )
        );
      }
    );
  }
}
