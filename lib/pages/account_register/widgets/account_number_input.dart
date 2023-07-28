import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/account_register/account_register.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class AccountNumberInput extends StatelessWidget {
  AccountNumberInput({super.key});
  final NumberSeparatorFormatter _numberSeparatorFormatter = NumberSeparatorFormatter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountRegisterBloc, AccountRegisterState>(
      buildWhen: (previous, current) => previous.accountNumber != current.accountNumber,
      builder: (context, state) {
        return TextField(
          key: const Key('add_account_number_textfield'),
          inputFormatters: [_numberSeparatorFormatter],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            prefixIcon: const Icon(FontAwesomeIcons.hashtag),
            labelText: 'Account Number',
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorText: state.accountNumber.displayError?.text(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            )
          ),
          onChanged: (value) => context.read<AccountRegisterBloc>().add(AccountNumberChanged(value))
        );
      }
    );
  }
}