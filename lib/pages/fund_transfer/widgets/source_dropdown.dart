import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';
import 'package:fcb_pay_app/pages/home/home.dart';

class SourceDropdown extends StatelessWidget {
  const SourceDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountDisplayBloc, AccountDisplayState>(
      builder: (context, state) {
        if (state is AccountDisplayInProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is AccountDisplaySuccess) {
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
                  hint: const Text("Select source account"),
                  style: const TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.w700,
                    overflow: TextOverflow.ellipsis
                  ),
                  value: fundState.sourceDropdown.value,
                  validator: (_) => fundState.sourceDropdown.displayError?.text(),
                  onChanged: (value) => context.read<FundTransferBloc>().add(SourceAccountChanged(value!)),
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