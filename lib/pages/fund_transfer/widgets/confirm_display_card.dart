import 'package:flutter/material.dart';

import 'package:fcb_pay_app/utils/utils.dart';

class ConfirmDisplayCard extends StatelessWidget {
  const ConfirmDisplayCard({
    super.key,
    required this.amount,
    required this.source,
    required this.recipient,
    required this.message
  });
  final String amount;
  final String source;
  final String recipient;
  final String message;

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
                text: "Confirm Transfer",
                fontSize: 18,
                color: Colors.green
              ),
              const SizedBox(height: 12),
              CustomRowTextDisplay( // source display
                title: "source",
                content: source.isNotEmpty ? source : "select source",
                color: source.isNotEmpty ? null : Colors.red
              ),
              const SizedBox(height: 12),
              CustomRowTextDisplay( // recipient display
                title: "recipient",
                content: recipient.isNotEmpty ? recipient : "select recipient",
                color: recipient.isNotEmpty ? null : Colors.red
              ),
              const SizedBox(height: 12),
              message.isNotEmpty  // conditional message data display
              ? CustomRowTextDisplay(
                  title: "message",
                  content: message
                )
              : const SizedBox.shrink(),
              const Divider(thickness: 2),
              const SizedBox(height: 12),
              CustomRowTextDisplay( // amount display
                title: "transfer amount",
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