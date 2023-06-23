import 'package:flutter/material.dart';

import 'package:fcb_pay_app/pages/accounts/accounts.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';

class AccountsView extends StatelessWidget {
  const AccountsView({super.key});

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
                TransactionHistoryView(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}