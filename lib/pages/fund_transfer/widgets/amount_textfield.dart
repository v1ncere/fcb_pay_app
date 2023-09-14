import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class AmountTextField extends StatelessWidget {
  const AmountTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FundTransferBloc, FundTransferState>(
      buildWhen: (previous, current) => previous.amount != current.amount,
      builder: (context, state) {
        return TextField(
          key: const Key('fund_amount_input'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: <ThousandsFormatter>[ThousandsFormatter(allowFraction: true)],
          onChanged: (amount) => context.read<FundTransferBloc>().add(AmountChanged(amount)),
          style: const TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.w700
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(30, 37, 193, 102),
            border: SelectedInputBorderWithShadow(
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