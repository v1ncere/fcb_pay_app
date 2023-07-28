import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fcb_pay_app/app/app.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        FontAwesomeIcons.rightFromBracket,
        color: Colors.redAccent
      ),
      onPressed: () => context.read<AppBloc>().add(AppLogoutRequested())
    );
  }
}