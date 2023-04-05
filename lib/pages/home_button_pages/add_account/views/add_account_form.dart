import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/functions/account_number_formatter.dart';
import 'package:fcb_pay_app/pages/home_button_pages/home_button_pages.dart';

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
            errorText: state.accountNumber.displayError?.text(),
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
        if(state.status.isSuccess) {
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isInProgress
          ? const CircularProgressIndicator()
          : ElevatedButton(
            key: const Key('add_account_number_submit_button'),
            style: ElevatedButton.styleFrom(elevation: 0),
            onPressed: state.isValid
              ? () => context.read<AddAccountBloc>().add(AccountFormSubmitted())
              : null,
            child: const Text('ADD'),
          );
      },
    );
  }

  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        border: Border.all(color: Colors.green, width: 3),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            spreadRadius: 2.0,
            blurRadius: 8.0,
            offset: Offset(2, 4),
          )
        ],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          const Icon(Icons.favorite, color: Colors.green ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Something went wrong!', style: TextStyle(color: Colors.green)),
          ),
          const Spacer(),
          TextButton(onPressed: () => debugPrint("Undid"), child: const Text("Undo"))
        ],
      )
    ),
  );
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAccountBloc, AddAccountState>(
      buildWhen:  (previous, current) => previous.status != current.status,
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