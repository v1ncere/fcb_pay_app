import 'package:flutter/material.dart';

import 'package:fcb_pay_app/pages/account_settings/account_settings.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: AccountSettingsPage());

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: AccountSettingsView(),
    );
  }
}