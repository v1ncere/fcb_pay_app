import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/bottom_appbar_home/bottom_appbar_home.dart';
import 'package:fcb_pay_app/pages/bottom_appbar_payment/bottom_appbar_payment.dart';

class PaymentAccountDropdown extends StatelessWidget {
  const PaymentAccountDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDisplayBloc, HomeDisplayState>(
      builder: (context, state) {
        if(state is HomeDisplayLoadInProgress) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is HomeDisplayLoadSuccess) {
          return BlocBuilder<PaymentBloc, PaymentState>(
            buildWhen: (previous, current) => previous.status != current.status || current.isValid,
            builder: (paymentContext, paymentState) {
              return Theme(
                data: Theme.of(context).copyWith(canvasColor: Colors.green),
                child: DropdownButtonFormField<String> (
                  value: paymentState.accountDropdown.value,
                  icon: const Icon(FontAwesomeIcons.caretDown, color: Colors.green),        
                  iconSize: 18,
                  elevation: 16,
                  isExpanded: true,
                  validator: (_) => paymentState.accountDropdown.displayError?.text(),
                  style: const TextStyle(color: Colors.black45, fontWeight: FontWeight.w700, overflow: TextOverflow.ellipsis),
                  onChanged: (value) => context.read<PaymentBloc>().add(AccountValueChanged(value!)),
                  items: state.homeDisplay.map((item) {
                    return DropdownMenuItem<String> (
                      value: item.keyId.toString(),
                      child: Text("${item.keyId}"),
                    );
                  }).toList(),
                ),
              );
            },
          );
        }
        if (state is HomeDisplayLoadError) {
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
      },
    );
  }
}