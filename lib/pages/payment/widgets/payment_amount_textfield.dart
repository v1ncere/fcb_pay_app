import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/payment/payment.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class PaymentAmountTextField extends StatelessWidget {
  const PaymentAmountTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc,PaymentState>(
      buildWhen: (previous, current) => previous.amount != current.amount,
      builder: (context, state) {
        return TextField(
          key: const Key('payment_amount_input'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: <ThousandsFormatter>[ThousandsFormatter(allowFraction: true)],
          onChanged: (amount) => context.read<PaymentBloc>().add(AmountTextFieldChanged(amount)),
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w700
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(30, 37, 193, 102),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: const Icon(FontAwesomeIcons.pesoSign),
            labelText: 'Amount',
            labelStyle: const TextStyle(color: Colors.black26),
            errorText: state.amount.displayError?.text()
          )
        );
      }
    );
  }
}