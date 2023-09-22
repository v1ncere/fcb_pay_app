import 'package:fcb_pay_app/pages/dynamic_viewer/dynamic_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';
import 'package:fcb_pay_app/pages/home/home.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class SourceDropdown extends StatelessWidget {
  const SourceDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountDisplayBloc, AccountDisplayState>(
      builder: (context, state) {
        if (state is AccountDisplayInProgress) {
          return const Center(child: ShimmerRectLoading());
        }
        if (state is AccountDisplaySuccess) {
          return BlocBuilder<WidgetsBloc, WidgetsState>(
            builder: (widgetsContext, widgetsState) {
              return CustomDropdownButton(
                value: widgetsState.source,
                hint: const Text("Select source account"),
                validator: (_) => null,
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