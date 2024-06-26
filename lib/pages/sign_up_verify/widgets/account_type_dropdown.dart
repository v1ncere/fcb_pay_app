import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';
import '../sign_up_verify.dart';

class AccountTypeDropdown extends StatelessWidget {
  const AccountTypeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpVerifyBloc, SignUpVerifyState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please choose the type of product',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true, // this will align the menu to the button
                child: DropdownButtonFormField(    
                  hint: const Text('Select a product'),
                  borderRadius: BorderRadius.circular(15),
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(borderSide: BorderSide.none)
                  ),
                  onChanged: (value) => context.read<SignUpVerifyBloc>().add(AccountTypeDropdownChanged(value!)),
                  items: AccountType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      enabled: !type.isUnknown,
                      child: type.isUnknown ? _accountTitle() : Text(type.name)
                    );
                  }).toList()
                )
              )
            )
          ]
        );
      }
    );
  }

  // UTILITY METHODS
  Widget _accountTitle() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account Type', 
          style: TextStyle(
            fontWeight: FontWeight.bold
          )
        ),
        Divider()
      ]
    );
  }
}