import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/scanner/scanner.dart';

class ScannerTransactionView extends StatelessWidget {
  const ScannerTransactionView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transaction', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700),),
        ),
        body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: BlocListener<ScannerDisplayBloc, ScannerDisplayState>(
              listenWhen: (previous, current) => previous.status != current.status,
              listener: (context, state) {
                if (state.status.isFailure) {
                  ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(state.error ?? 'Oops! Something went wrong. Please try again.')));
                }
              },
              child: Column(
                children: [
                  _ScannerTransactionDisplayQrData(),
                  const SizedBox(height: 20),
                  _ScannerTransactionAmountInput(),
                  const SizedBox(height: 20),
                  _ScannerPaymentSubmitButton()
                ],
              ),
            )
        ),
      ),
    );
  }
}

class _ScannerTransactionDisplayQrData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScannerDisplayBloc, ScannerDisplayState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status.isSuccess) {
          final date = DateTime.now();
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.merchantId, style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        )),
                        Text(state.merchantName, style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        )),
                        Text(state.referenceLabel, style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        )),
                        const SizedBox(height: 50),
                        Text(state.senderTransactionRef, style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        )),
                        Text(state.traceNumber, style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        )),
                      ]
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                      Text("${date.day}/${date.month}/${date.year}", style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                      )),
                      Text("${date.hour}:${date.minute}", style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                      )),
                      ]
                    ),
                  ],
                )
              ]
            ),
          );
        }
        if (state.status.isFailure) {
          return Center(child: Text('${state.error}'),);
        }
        else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class _ScannerTransactionAmountInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScannerTransactionBloc,ScannerTransactionState>(
      buildWhen: (previous, current) => previous.amount != current.amount,
      builder: (context, state) {
        return TextField(
          key: const Key('scanner_transaction_amount_input'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')), 
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
          ],
          onChanged: (amount) => context.read<ScannerTransactionBloc>().add(ScannerAccountValueChanged(amount)),
          style: const TextStyle(color: Colors.black45, fontWeight: FontWeight.w700),
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

class _ScannerPaymentSubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScannerTransactionBloc,ScannerTransactionState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if(state.status.isSuccess) {
          context.flow<AppStatus>().update((next) => AppStatus.authenticated);
          ScaffoldMessenger.of(context).showSnackBar(_snackBar(
            "Payment sent!",
            FontAwesomeIcons.solidCircleCheck,
            Colors.white,
          ));
        }
        if(state.status.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(_snackBar(
            "Something went wrong!",
            FontAwesomeIcons.triangleExclamation,
            Colors.red,
          ));
        }
      },
      buildWhen: (previous, current) => previous.status != current.status || current.isValid,
      builder: (context, state) {
        return state.status.isInProgress
        ? const CircularProgressIndicator()
        : Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRect(
              child: Material(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF009405),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  splashColor: Colors.white38,
                  onTap: state.isValid
                    ? () => context.read<ScannerTransactionBloc>().add(ScannerTransactionSubmitted())
                    : null,
                  child: const SizedBox(
                    height: 45,
                    width: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('PAY',
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
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

SnackBar _snackBar(String input, IconData icon, Color color) {
  return SnackBar(
    elevation: 0,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FaIcon(icon, color: color),
        const SizedBox(width: 10),
        Padding(
          padding: const  EdgeInsets.only(left: 8.0),
          child: Text(input, style: TextStyle(color: color)),
        ),
      ],
    ),
  );
}