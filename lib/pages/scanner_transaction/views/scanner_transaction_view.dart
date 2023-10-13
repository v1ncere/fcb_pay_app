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
                AccountDropdown(),
                SizedBox(height: 10),
                AccountCardInfo(),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(text: "Amount:", color: Colors.black54),
                  ]
                ),
                SizedBox(height: 5),
                AmountInput(),
                SizedBox(height: 10), 
                Divider(thickness: 2), // line divider ---------------------
                SizedBox(height: 5),
                CustomText(text: "Please verify your data for accuracy and completeness before proceeding with the payment.",
                  fontSize: 12,
                  color: Colors.teal
                ),
                SizedBox(height: 15),
                SubmitButton(),
                SizedBox(height: 20)
              ]
            )
          )
        )
      )
    );
  }
}