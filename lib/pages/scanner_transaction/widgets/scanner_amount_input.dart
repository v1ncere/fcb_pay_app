import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/scanner_transaction/scanner_transaction.dart';

class ScannerAmountInput extends StatelessWidget {
  const ScannerAmountInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScannerTransactionBloc, ScannerTransactionState>(
      buildWhen: (previous, current) => previous.inputAmount != current.inputAmount,
      builder: (context, state) {
        return TextField(
          key: const Key('scanner_transaction_amount_input'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')), 
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
          ],
          style: const TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.w700
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black12,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: const Icon(FontAwesomeIcons.pesoSign),
            labelText: 'Amount',
            errorText: state.inputAmount.displayError?.text(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            )
          ),
          onChanged: (value) {
            context.read<ScannerTransactionBloc>().add(ScannerAmountValueChanged(value));
          }
        );
      }
    );
  }
}