import 'package:fcb_pay_app/ui/settings/widgets/settings_selection.dart';
import 'package:flutter/cupertino.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SettingsSelection(),
    );
  }
}