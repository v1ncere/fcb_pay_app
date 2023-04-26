import 'package:fcb_pay_app/pages/account_settings/account_settings.dart';
import 'package:flutter/material.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: AccountSettingsView(),
    );
  }
}