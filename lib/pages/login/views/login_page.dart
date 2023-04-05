import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/login/login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => LoginBloc(firebaseAuthService: FirebaseAuthRepository()),
      child: const LoginForm(),
    );
  }
}