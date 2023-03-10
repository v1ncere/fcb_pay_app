import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/repository/repository.dart';
import 'package:fcb_pay_app/pages/login/login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseAuthRepository(),
        child: BlocProvider(
        create: (context) => LoginCubit(context.read<FirebaseAuthRepository>()),
        child: const Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}