import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/pages/account_settings/account_settings.dart';

class PopUpSettingsButton extends StatelessWidget {
  const PopUpSettingsButton({
    super.key,
    required this.account
  });
  final String account;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      clipBehavior: Clip.antiAlias,
      icon: const Icon(FontAwesomeIcons.ellipsis, color: Colors.white),
      iconSize: 18,
      onSelected: (value) {
        context.read<AccountSettingsBloc>().add(
          AccountEventPressed(
            account: account,
            method: value
          )
        );
      },
      itemBuilder: (context) {
        final settings = ['edit', 'delete'];
        return settings.map((String value) {
          return PopupMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList();
      }
    );
  }
}