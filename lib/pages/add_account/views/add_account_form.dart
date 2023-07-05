import 'package:flutter/material.dart';

import 'package:fcb_pay_app/pages/add_account/widgets/widgets.dart';

class AddAccountForm extends StatelessWidget {
  const AddAccountForm({super.key});
  
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
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AccountNumberInput(),
              const SizedBox(height: 10.0),
              const AccountNameInput(),
              const SizedBox(height: 16.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 8.0),
                  SubmitAccountButton()
                ]
              )
            ]
          )
        )
      )
    );
  }
}
