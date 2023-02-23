import 'package:flutter/material.dart';
import 'package:fcb_pay_app/pages/register/register.dart';

class AccountNumberPage extends StatelessWidget {
  const AccountNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: AccountNumberForm(),
    );
  }
}