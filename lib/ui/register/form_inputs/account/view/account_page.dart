import 'package:fcb_pay_app/ui/register/form_inputs/account/view/account_form.dart';
import 'package:flutter/material.dart';

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