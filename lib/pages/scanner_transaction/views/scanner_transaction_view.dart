import 'package:flutter/material.dart';

import 'package:fcb_pay_app/pages/scanner_transaction/widgets/widgets.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

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
        body: const Padding(
          padding: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QrDataDisplay(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(text: "Account:", color: Colors.black54)
                  ]
                ),
                SizedBox(height: 5),
                ScannerAccountDropdown(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(text: "Amount:", color: Colors.black54),
                  ]
                ),
                SizedBox(height: 5),
                ScannerAmountInput(),
                SizedBox(height: 20),
                SubmitButton(),
                SizedBox(height: 20)
              ]
            ),
          )
        )
      )
    );
  }
}