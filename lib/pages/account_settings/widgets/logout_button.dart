import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Row(
        children: [
          Text(
            'logout',
            style: TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.w700,
              shadows: <Shadow>[
                Shadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  blurRadius: 3,
                  offset: const Offset(0, 1.5)
                )
              ]
            )
          ),
          const SizedBox(width: 5),
          const Icon(
            FontAwesomeIcons.rightFromBracket,
            size: 16,
            color: Colors.yellow
          )
        ]
      ),
      onPressed: () => context.read<AppBloc>().add(AppLogoutRequested())
    );
  }
}