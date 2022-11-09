
import 'package:fcb_pay_app/ui/register/form_inputs/account/bloc/account_bloc.dart';
import 'package:fcb_pay_app/ui/register/form_inputs/account/view/account_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => AccountBloc(),
        child: const AccountForm(),
      ),
    );
  }
}