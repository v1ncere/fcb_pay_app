import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/home/home.dart';
import 'package:fcb_pay_app/pages/payment/payment.dart';
import 'package:fcb_pay_app/utils/utils.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class AccountDropdown extends StatelessWidget {
  const AccountDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountDisplayBloc, AccountDisplayState>(
      builder: (context, state) {
        if(state is AccountDisplayInProgress) {
          return const Center(child: ShimmerRectLoading());
        }
        if (state is AccountDisplaySuccess) {
          return BlocBuilder<PaymentBloc, PaymentState>(
            buildWhen: (previous, current) => previous.formzStatus != current.formzStatus || current.isValid,
            builder: (paymentContext, paymentState) {
              return CustomDropdownButton(
                value: paymentState.accountDropdown.value,
                hint: const Text("Select account"),
                validator: (_) => paymentState.accountDropdown.displayError?.text(),
                onChanged: (value) => context.read<PaymentBloc>().add(AccountValueChanged(value!)),
                items: state.accounts.map((item) {
                  return DropdownMenuItem<String> (
                    value: item.keyId.toString(),
                    child: Text("${item.keyId}")
                  );
                }).toList()
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