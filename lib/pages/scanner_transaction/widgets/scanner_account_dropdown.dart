import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/home/home.dart';
import 'package:fcb_pay_app/pages/scanner_transaction/scanner_transaction.dart';

class ScannerAccountDropdown extends StatelessWidget {
  const ScannerAccountDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountDisplayBloc, AccountDisplayState>(
      builder: (context, state) {
        if (state is AccountDisplayInProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is AccountDisplaySuccess) {
          return BlocBuilder<ScannerTransactionBloc, ScannerTransactionState>(
            buildWhen: (previous, current) => previous.formStatus != current.formStatus || current.isValid,
            builder: (scanContext, scanState) {
              return Theme(
                data: Theme.of(context).copyWith(canvasColor: Colors.green),
                child: DropdownButtonFormField<String>(
                  icon: const Icon(
                    FontAwesomeIcons.caretDown,
                    color: Colors.green
                  ),
                  iconSize: 18,
                  elevation: 16,
                  isExpanded: true,
                  style: const TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.w700
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                  hint: const Text("Select account"),
                  value: scanState.accountDropdown.value,
                  validator: (_) => scanState.accountDropdown.displayError?.text(),
                  onChanged: (value) => context.read<ScannerTransactionBloc>().add(ScannerAccountValueChanged(value!)),
                  items: state.accounts.map((item) {
                    return DropdownMenuItem<String> (
                      value: item.keyId.toString(),
                      child: Text('${item.keyId}')
                    );
                  }).toList()
                )
              );
            }
          );
        }
        if (state is AccountDisplayError) {
          return Center(
            child: Text(state.error,
              style: const TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w900,
                fontSize: 16.0
              )
            )
          );
        }
        else { 
          return const SizedBox.shrink();
        }
      }
    );
  }
}