import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../re_authenticate.dart';

class ReauthenticatePage extends StatelessWidget {
  const ReauthenticatePage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: ReauthenticatePage());
  static final _firebaseAuth = FirebaseAuthRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _firebaseAuth,
      child: BlocProvider(
        create: (context) => ReAuthBloc(firebaseAuth: _firebaseAuth),
        child: const ReauthenticateView()
      )
    );
  }
}