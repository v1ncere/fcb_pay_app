import 'package:flutter/material.dart';
import 'package:fcb_pay_app/pages/register/register.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: AccountForm(),
    );
  }
}