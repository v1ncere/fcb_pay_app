import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login.dart';

class LoginOptions extends StatelessWidget {
  const LoginOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextButton(
          onPressed: () => state.loginOption.isEmail
          ? context.read<LoginBloc>().add(const LoginOptionChanged(LoginOption.phone))
          : context.read<LoginBloc>().add(const LoginOptionChanged(LoginOption.email)),
          child: Text(
            state.loginOption.isEmail
            ? 'WITH PHONE NUMBER'
            : 'WITH EMAIL AND PASSWORD',
            style: TextStyle(
              color: const Color(0xFF25C166),
              shadows: [
                Shadow(
                  blurRadius: 2,
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0.2, 1.0)
                )
              ]
            )
          ),
        );
      }
    );
  }
}
