import 'package:fcb_pay_app/pages/fund_transfer/fund_transfer.dart';
import 'package:flutter/material.dart';

class FundTransferView extends StatelessWidget {
  const FundTransferView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fund Transfer",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w700
          )
        ),
      ),
      body: const Column(
        children: [
          CustomText(text: "From"),

        ]
      ),
    );
  }
}