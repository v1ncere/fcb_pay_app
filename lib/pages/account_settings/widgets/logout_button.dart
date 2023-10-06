import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/app/app.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Row(
        children: [
          Text(
            'Logout',
            style: TextStyle(
              color: Colors.yellowAccent,
              fontWeight: FontWeight.w700,
              shadows: <Shadow>[
                Shadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  blurRadius: 3,
                  offset: const Offset(0, 1.5)
                )
              ]
            )
          )
        ]
      ),
      onPressed: () => context.read<AppBloc>().add(AppLogoutRequested())
    );
  }
}