import 'package:flutter/material.dart';

import 'package:fcb_pay_app/pages/account_add/widgets/widgets.dart';
import 'package:fcb_pay_app/widgets/custom_widgets/custom_text.dart';

class AccountAddForm extends StatelessWidget {
  const AccountAddForm({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text(
          "Add Account",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w700
          )
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(text: 'Account name', color: Color(0xFF25C166)),
              const SizedBox(height: 2.0),
              const AccountNameInput(),
              const SizedBox(height: 10.0),
              const CustomText(text: 'Account number', color: Color(0xFF25C166)),
              const SizedBox(height: 2.0),
              AccountNumberInput()
            ]
          )
        )
      ),
      bottomSheet: const Padding(
        padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(thickness: 2), // line divider ---------------------
            CustomText(
              text: "Please verify your data for accuracy and completeness before proceeding with the registration.",
              fontSize: 12,
              color: Colors.teal,
            ),
            SizedBox(height: 10.0),
            SubmitAccountButton()
          ]
        )
      )
    );
  }
}
