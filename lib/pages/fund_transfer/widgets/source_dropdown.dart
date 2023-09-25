import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';
import 'package:fcb_pay_app/pages/home_dynamic/home_dynamic.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class SourceDropdown extends StatelessWidget {
  const SourceDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        if (state is AccountsInProgress) {
          return const Center(child: ShimmerRectLoading());
        }
        if (state is AccountsSuccess) {
          return BlocBuilder<FundTransferBloc, FundTransferState>(
            buildWhen: (previous, current) =>
              previous.status != current.status || 
              current.isValid,
            builder: (fundContext, fundState) {
              return CustomDropdownButton(
                value: fundState.sourceDropdown.value,
                hint: const Text("Select source account"),
                validator: (_) => fundState.sourceDropdown.displayError?.text(),
                onChanged: (value) => context.read<FundTransferBloc>().add(SourceAccountChanged(value!)),
                items: state.accounts.map((item) {
                  return DropdownMenuItem<String> (
                    value: item.keyId.toString(),
                    child: Text('${item.keyId}')
                  );
                }).toList(),
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