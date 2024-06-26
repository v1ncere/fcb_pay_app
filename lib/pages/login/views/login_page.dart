import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: LoginPage());
  static final _authRepository = FirebaseAuthRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _authRepository,
      child: BlocProvider(
        create: (context) => LoginBloc(firebaseAuth: _authRepository),
        child: const LoginForm()
      )
    );
  }
}