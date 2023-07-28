import 'package:flutter/material.dart';

import 'package:fcb_pay_app/utils/utils.dart';

class ConfirmDisplayCard extends StatelessWidget {
  const ConfirmDisplayCard({
    super.key,
    required this.amount,
    required this.account,
    required this.institution,
    required this.additional,
    required this.isInputted
  });
  final String amount;
  final String account;
  final String institution;
  final String additional;
  final bool isInputted;

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
              const CustomizedText(
                text: "Confirm Payment",
                fontSize: 18,
                color: Colors.green
              ),
              const SizedBox(height: 12),
              CustomRowTextDisplay(
                title: "account",
                content: account.isNotEmpty ? account : "Please select an account from the drop-down menu.",
                color: account.isNotEmpty ? null :const Color.fromARGB(132, 244, 67, 54)
              ),
              const SizedBox(height: 12),
              CustomRowTextDisplay(
                title: "institution",
                content: institution.isNotEmpty ? institution : "Please select an institution from the drop-down menu.",
                color: institution.isNotEmpty ? null :const Color.fromARGB(132, 244, 67, 54)
              ),
              const SizedBox(height: 12),
              additional.isNotEmpty
              ? CustomRowTextDisplay(
                  title: "additional fields",
                  content: isInputted ? additional : "Please fill out all additional fields.",
                  color: isInputted ? null :const Color.fromARGB(132, 244, 67, 54)
                )
              : const SizedBox.shrink(),
              const Divider(thickness: 2),
              const SizedBox(height: 12),
              CustomRowTextDisplay(
                title: "payment amount",
                content: amount.isNotEmpty ? amount : "Please fill out the amount.",
                contentFontSize: amount.isNotEmpty ? 18 : null,
                color: amount.isNotEmpty ? const Color.fromARGB(255, 14, 1, 0) :const Color.fromARGB(132, 244, 67, 54),
                contentFontWeight: FontWeight.w900,
              )
            ]
          )
        )
      )
    );
  }
}