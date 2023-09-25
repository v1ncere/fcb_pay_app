import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/home_dynamic/home_dynamic.dart';
import 'package:fcb_pay_app/pages/scanner_transaction/scanner_transaction.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class AccountDropdown extends StatelessWidget {
  const AccountDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        if (state is AccountsInProgress) {
          return const Center(child: ShimmerRectLoading());
        }
        if (state is AccountsSuccess) {
          return BlocBuilder<ScannerTransactionBloc, ScannerTransactionState>(
            buildWhen: (previous, current) => previous.formStatus != current.formStatus || current.isValid,
            builder: (scanContext, scanState) {
              return CustomDropdownButton(
                value: scanState.accountDropdown.value,
                hint: const Text("Select account"),
                validator: (_) => scanState.accountDropdown.displayError?.text(),
                onChanged: (value) => context.read<ScannerTransactionBloc>().add(ScannerAccountValueChanged(value!)),
                items: state.accounts.map((item) {
                  return DropdownMenuItem<String> (
                    value: item.keyId.toString(),
                    child: Text('${item.keyId}')
                  );
                }).toList()
              );
            }
          );
        }
        if (state is AccountsError) {
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