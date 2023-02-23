import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/pages/home_transaction_button_pages/home_transaction_button_pages.dart';
import 'package:fcb_pay_app/pages/register/register.dart' hide AccountNumberChanged;

class AddAccountForm extends StatelessWidget {
  const AddAccountForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ), 
        title: const Text("Add Account", style: TextStyle(color: Colors.green)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _AccountNumberInput(),
              const SizedBox(height: 16.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _CancelButton(),
                  const SizedBox(width: 8.0,),
                  _SubmitDataButton(),
                ],
              )
            ]
          ),
        ),
      ),
    );
  }
}

class _AccountNumberInput extends StatelessWidget {
  final AccountsInputFormatter _accountsInputFormatter = AccountsInputFormatter();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAccountBloc, AddAccountState>(
      buildWhen: (previous, current) => previous.accountNumber != current.accountNumber,
      builder: (context, state) {
        return TextField(
          key: const Key('add_account_number_textfield'),
          inputFormatters: [_accountsInputFormatter],
          onChanged: (value) => context.read<AddAccountBloc>().add(AccountNumberChanged(value)),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Account Number',
            errorText: state.accountNumber.invalid
              ? state.accountNumber.error?.message 
              : null,
          ),
        );
      },
    );
  }
}

class _SubmitDataButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddAccountBloc, AddAccountState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if(state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
          ? const CircularProgressIndicator()
          : ElevatedButton(
            key: const Key('add_account_number_submit_button'),
            style: ElevatedButton.styleFrom(elevation: 0),
            onPressed: state.status.isValidated 
              ? () => context.read<AddAccountBloc>().add(AccountFormSubmitted())
              : null,
            child: const Text('ADD'),
          );
      },
    );
  }
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAccountBloc, AddAccountState>(
      buildWhen: ((previous, current) => previous.status != current.status),
      builder: (context, state) {
        return TextButton(
          key: const Key('add_account_cancel_button'),
          onPressed: Navigator.of(context).pop,
          child: const Text('BACK'),
        );
      },
    );
  }
}