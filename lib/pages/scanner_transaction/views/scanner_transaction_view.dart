import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/pages/scanner/scanner.dart';
import 'package:fcb_pay_app/pages/scanner_transaction/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class ScannerTransactionView extends StatelessWidget {
  const ScannerTransactionView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transaction',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w700
            )
          )
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BlocListener<ScannerDisplayBloc, ScannerDisplayState>(
            listenWhen: (previous, current) => previous.status != current.status,
            listener: (context, state) {
              if (state.status.isFailure) {
                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(customSnackBar(
                    state.error,
                    FontAwesomeIcons.bomb,
                    Colors.redAccent
                  )
                );
              }
            },
            child: const SingleChildScrollView(
              child: Column(
                children: [
                  QrDataDisplay(),
                  SizedBox(height: 20),
                  AmountInput(),
                  SizedBox(height: 20),
                  SubmitButton()
                ]
              )
            )
          )
        )
      )
    );
  }
}

