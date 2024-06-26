import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../../home/home.dart';
import '../scanner_transaction.dart';

class AccountDropdown extends StatelessWidget {
  const AccountDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsHomeBloc, AccountsHomeState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: ShimmerRectLoading());
        }
        if (state.status.isSuccess) {
          return BlocBuilder<ScannerTransactionBloc, ScannerTransactionState>(
            buildWhen: (previous, current) => previous.formStatus != current.formStatus || current.isValid,
            builder: (scanContext, scanState) {
              return CustomDropdownButton(
                value: scanState.accountDropdown.value,
                hint: const Text('Select account'),
                validator: (_) => scanState.accountDropdown.displayError?.text(),
                onChanged: (value) => context.read<ScannerTransactionBloc>().add(ScannerAccountValueChanged(value!)),
                items: state.accountList.map((item) {
                  return DropdownMenuItem<String> (
                    value: item.accountKeyID.toString(),
                    child: Text('${item.accountKeyID}'),
                    onTap: () => context.read<ScannerTransactionBloc>().add(ScannerAccountModelChanged(item)),
                  );
                }).toList()
              );
            }
          );
        }
        if (state.status.isError) {
          return Center(
            child: Text(state.message,
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