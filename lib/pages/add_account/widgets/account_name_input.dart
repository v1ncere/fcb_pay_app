import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/add_account/add_account.dart';

class AccountNameInput extends StatelessWidget {
  const AccountNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAccountBloc, AddAccountState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          key: const Key('add_account_name_textfield'),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            prefixIcon: const Icon(FontAwesomeIcons.addressCard),
            labelText: 'Account Name',
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorText: state.name.displayError?.text(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            )
          ),
          onChanged: (name) => context.read<AddAccountBloc>().add(AccountNameChanged(name))
        );
      }
    );
  }
}