import 'package:flutter/material.dart';

import 'package:fcb_pay_app/pages/account/widgets/widgets.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Accounts",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w700
            )
          )
        ),
        body: const Column(
          children: [
            SizedBox(height: 10),
            ContainerBody(
              children: [
                ActionButtons(),
                SizedBox(height: 20),
                TransactionHistoryList()
              ]
            )
          ]
        )
      )
    );
  }
}