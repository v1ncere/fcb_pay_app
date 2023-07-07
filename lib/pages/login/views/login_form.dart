import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:fcb_pay_app/pages/login/login.dart';
import 'package:fcb_pay_app/pages/login/widgets/widgets.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: BlocListener<LoginBloc, LoginState> (
            listenWhen: (previous, current) => previous.status != current.status,
            listener: (context, state) {
              if (state.status.isFailure) {
                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(state.errorMessage ?? 'Authentication Failure')));
              }
            },
            child: Align(
              alignment: const Alignment(0, -1/3),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/fcb-logo.png', height: 120),
                    const SizedBox(height: 16),
                    const EmailInput(),
                    const SizedBox(height: 12),
                    const PasswordInput(),
                    const SizedBox(height: 16),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SignInText(),
                        LoginButton()
                      ]
                    ),
                    const SizedBox(height: 4),
                    const SignUpButton()
                  ]
                )
              )
            )
          )
        )
      )
    );
  }
}