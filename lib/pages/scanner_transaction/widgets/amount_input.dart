import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import '../../../utils/utils.dart';
import '../scanner_transaction.dart';

class AmountInput extends StatelessWidget {
  const AmountInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScannerTransactionBloc, ScannerTransactionState>(
      buildWhen: (previous, current) => previous.inputAmount != current.inputAmount,
      builder: (context, state) {
        final index = state.qrDataList.indexWhere((e) => e.id == 'main54'); // find id [main54]
        if (index != -1) { // if not found result is -1
          return TextField(
            key: const Key('scanner_transaction_amount_input'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <ThousandsFormatter>[ThousandsFormatter(allowFraction: true)],
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w700
            ),

            controller: TextEditingController(text: state.inputAmount.value),
            enabled: false,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(30, 37, 193, 102),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: const Icon(FontAwesomeIcons.pesoSign),
              labelText: 'Amount',
              labelStyle: const TextStyle(color: Colors.black26),
              errorText: state.inputAmount.displayError?.text(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              )
            )
          );
        } else {
          return TextField(
            key: const Key('scanner_transaction_amount_input'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <ThousandsFormatter>[ThousandsFormatter(allowFraction: true)],
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w700
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(30, 37, 193, 102),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: const Icon(FontAwesomeIcons.pesoSign),
              labelText: 'Amount',
              labelStyle: const TextStyle(color: Colors.black26),
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
      }
    );
  }
}