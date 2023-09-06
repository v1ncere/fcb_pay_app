import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';
import 'package:fcb_pay_app/utils/utils.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class RecipientDropdown extends StatelessWidget {
  const RecipientDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FundTransferAccountBloc, FundTransferAccountState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: ShimmerRectLoading());
        }
        if (state.status.isSuccess) {
          return BlocBuilder<FundTransferBloc, FundTransferState>(
            buildWhen: (previous, current) =>
              previous.status != current.status ||
              current.isValid,
            builder: (fundContext, fundState) {
              return CustomDropdownButton(
                value: fundState.recipientDropdown.value,
                hint: const Text("Select recipient account"),
                validator: (_) => fundState.recipientDropdown.displayError?.text(),
                onChanged: (value) => context.read<FundTransferBloc>().add(RecipientAccountChanged(value!)),
                items: state.transferAccount.map((item) {
                  return DropdownMenuItem<String> (
                    value: item.account,
                    child: Text(item.account),
                  );
                }).toList(),
              );
            }
          );
        }
        if (state.status.isError) {
          return Center(
            child: Text(state.error,
              style: const TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w900,
                fontSize: 16.0,
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