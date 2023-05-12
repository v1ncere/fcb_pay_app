import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/pages/account_settings/account_settings.dart';
import 'package:fcb_pay_app/utils/number_separator_formatter.dart';

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
        title: const Text(
          "Add Account",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w700
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _AccountNumberInput(),
              const SizedBox(height: 10.0),
              _AccountNameInput(),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //_CancelButton(),
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
  final NumberSeparatorFormatter _numberSeparatorFormatter = NumberSeparatorFormatter();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAccountBloc, AddAccountState>(
      buildWhen: (previous, current) => previous.accountNumber != current.accountNumber,
      builder: (context, state) {
        return TextField(
          key: const Key('add_account_number_textfield'),
          inputFormatters: [_numberSeparatorFormatter],
          onChanged: (value) => context.read<AddAccountBloc>().add(AccountNumberChanged(value)),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(FontAwesomeIcons.hashtag),
            labelText: 'Account Number',
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorText: state.accountNumber.displayError?.text(),
            
          ),
        );
      },
    );
  }
}

class _AccountNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAccountBloc, AddAccountState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          key: const Key('add_account_name_textfield'),
          onChanged: (name) => context.read<AddAccountBloc>().add(AccountNameChanged(name)),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(FontAwesomeIcons.addressCard),
            labelText: 'Account Name',
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorText: state.name.displayError?.text(),
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
          ScaffoldMessenger.of(context).showSnackBar(_snackBar(
            "Account Added!",
            FontAwesomeIcons.solidCircleCheck,
            Colors.white,
          ));
        }
        if(state.status.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(_snackBar(
            "Something went wrong!",
            FontAwesomeIcons.triangleExclamation,
            Colors.red,
          ));
        }
      },
      buildWhen: (previous, current) =>
        previous.status != current.status || current.isValid,
      builder: (context, state) {
        return state.status.isInProgress
          ? const CircularProgressIndicator()
          : ElevatedButton(
            key: const Key('add_account_submit_button'),
            style: ElevatedButton.styleFrom(elevation: 0),
            onPressed: state.isValid
              ? () => context.read<AddAccountBloc>().add(AccountFormSubmitted())
              : null,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: const [
                  Text('Submit', style: TextStyle(fontWeight: FontWeight.w700),),
                  SizedBox(width: 5),
                  Icon(FontAwesomeIcons.paperPlane)
                ],
              ),
            ),
          );
      },
    );
  }
}

SnackBar _snackBar(String input, IconData icon, Color color) {
  return SnackBar(
    elevation: 0,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FaIcon(icon, color: color),
        const SizedBox(width: 10),
        Padding(
          padding: const  EdgeInsets.only(left: 8.0),
          child: Text(input, style: TextStyle(color: color)),
        ),
      ],
    ),
  );
}