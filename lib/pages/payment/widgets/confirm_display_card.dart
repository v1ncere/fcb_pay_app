import 'package:flutter/material.dart';

import 'package:fcb_pay_app/utils/utils.dart';

class ConfirmDisplayCard extends StatelessWidget {
  const ConfirmDisplayCard({
    super.key,
    required this.amount,
    required this.account,
    required this.institution,
    required this.additional,
    required this.controllers
  });
  final String amount;
  final String account;
  final String institution;
  final String additional;
  final List<TextEditingController> controllers;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15)
        )
      ),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const CustomizedText( // title
                text: "Confirmation",
                fontSize: 18,
                color: Colors.green
              ),
              const SizedBox(height: 12),
              CustomRowTextDisplay( // account display
                title: "account",
                content: account.isNotEmpty ? account : "select account",
                color: account.isNotEmpty ? null : Colors.red
              ),
              const SizedBox(height: 12),
              CustomRowTextDisplay( // institution display
                title: "institution",
                content: institution.isNotEmpty ? institution : "select institution",
                color: institution.isNotEmpty ? null : Colors.red
              ),
              const SizedBox(height: 12),
              controllers.isNotEmpty  // conditional additional data display
              ? CustomRowTextDisplay(
                  title: "additional fields",
                  content: additional.isNotEmpty ? additional : "input additional data",
                  color: additional.isNotEmpty ? null : Colors.red
                )
              : const SizedBox.shrink(),
              const Divider(thickness: 2),
              const SizedBox(height: 12),
              CustomRowTextDisplay( // amount display
                title: "amount",
                content: amount.isNotEmpty ? amount : "input amount",
                contentFontSize: amount.isNotEmpty ? 18 : null,
                color: amount.isNotEmpty ? null : Colors.red
              )
            ]
          )
        )
      )
    );
  }
}