import 'package:flutter/material.dart';

import 'package:fcb_pay_app/pages/bottom_appbar_settings/bottom_appbar_settings.dart';

class BottomAppbarSettingsPage extends StatelessWidget {
  const BottomAppbarSettingsPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: BottomAppbarSettingsPage());

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: BottomAppbarSettingsView(),
    );
  }
}