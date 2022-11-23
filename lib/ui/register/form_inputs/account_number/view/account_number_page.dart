import 'package:fcb_pay_app/ui/register/form_inputs/account_number/view/account_number_form.dart';
import 'package:flutter/material.dart';

class AccountNumberPage extends StatelessWidget {
  const AccountNumberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: AccountNumberForm(),
    );
  }
}