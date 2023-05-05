import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/pages/payment/bloc/payment_bloc.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});
  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocListener<PaymentBloc, PaymentState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isFailure) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.errorMsg ?? 'Authentication Failure')));
            }
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Merchant ID: [27-03]",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black38,
                      fontSize: 12
                    ),
                  ),
                  Text("${date.day}/${date.month}/${date.year}",
                    style: const TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w700,
                      fontSize: 12
                    ),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Merchant Name: [59]",
                    style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w700,
                      fontSize: 12
                    ),),
                  Text(
                    "${date.hour}:${date.minute}",
                    style: const TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w700,
                      fontSize: 12
                    ),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Reference Label: [62-05]',
                    style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w700,
                      fontSize: 12
                    ),
                  )
                ]
              ),
              const SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "Sender Transaction Ref: [OFI]",
                    style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w700,
                      fontSize: 12
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "Trace Number: [CSO]",
                    style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w700,
                      fontSize: 12
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              _TransactionAmountInput(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _PaymentSubmitButton(),
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}

class _TransactionAmountInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc,PaymentState>(
      buildWhen: (previous, current) => previous.amount != current.amount,
      builder: (context, state) {
        return TextFormField(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')), 
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
          ],
          key: const Key('transaction_amount_input'),
          onChanged: (value) {
            context.read<PaymentBloc>().add(PaymentTransactionAmountChanged(value));
          },
          style: const TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.w700,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black12,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: const Icon(FontAwesomeIcons.pesoSign),
            labelText: 'Amount',
            errorText: state.amount.displayError?.text(),
          ),
        );
      },
    );
  }
}

class _PaymentSubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      buildWhen: (previous, current) => 
        previous.status != current.status ||
        current.isValid,
      builder: (context, state) {
        return state.status.isInProgress
        ? const CircularProgressIndicator()
        : ClipRect(
          child: Material(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFF009405),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              splashColor: Colors.white,
              onTap: state.isValid
                ? () => print('yamete kudasai')
                : null,
              child: SizedBox(
                height: 45,
                width: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'PAY',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      FontAwesomeIcons.coins, 
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                )
              ),
            ),
          ),
        );
      },
    );
  }
}