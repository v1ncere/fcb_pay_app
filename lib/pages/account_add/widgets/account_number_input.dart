import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

import '../account_add.dart';
import '../../../utils/utils.dart';

class AccountNumberInput extends StatelessWidget {
  const AccountNumberInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountAddBloc, AccountAddState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Account Number',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            TextFormField(
              inputFormatters: [
                NumberSeparatorFormatter(),
                LengthLimitingTextInputFormatter(19)
              ],
              keyboardType: TextInputType.number,
              maxLength: 19,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Account Number',
                errorText: state.accountNumber.displayError?.text(),  
              ),
              style: const TextStyle(height: 1.5),
              onChanged: (value) => context.read<AccountAddBloc>().add(AccountNumberChanged(value))
            )
          ]
        );
      }
    );
  }
}