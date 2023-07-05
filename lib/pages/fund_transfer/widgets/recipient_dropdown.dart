import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';

class RecipientDropdown extends StatelessWidget {
  const RecipientDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FundTransferAccountBloc, FundTransferAccountState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator())
          );
        }
        if (state.status.isSuccess) {
          return BlocBuilder<FundTransferBloc, FundTransferState>(
            buildWhen: (previous, current) =>
              previous.status != current.status ||
              current.isValid,
            builder: (fundContext, fundState) {
              return Theme(
                data: Theme.of(context).copyWith(canvasColor: Colors.green),
                child: DropdownButtonFormField<String>(
                  icon: const Icon(
                    FontAwesomeIcons.caretDown,
                    color: Colors.green
                  ),       
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: Colors.black12,
                  ),
                  iconSize: 18,
                  elevation: 16,
                  isExpanded: true,
                  hint: const Text("Select recipient account"),
                  validator: (_) => fundState.recipientDropdown.displayError?.text(),
                  style: const TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.w700,
                    overflow: TextOverflow.ellipsis
                  ),
                  value: fundState.recipientDropdown.value,
                  onChanged: (value) => context.read<FundTransferBloc>().add(RecipientAccountChanged(value!)),
                  items: state.transferAccount.map((item) {
                    return DropdownMenuItem<String> (
                      value: item.account,
                      child: Text(item.account),
                    );
                  }).toList()
                )
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