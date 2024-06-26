import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../sign_up_verify.dart';

class SignUpVerifyPage extends StatelessWidget {
  const SignUpVerifyPage({super.key});
  static Page<void> page() => const MaterialPage(child: SignUpVerifyPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpVerifyBloc(firebaseRealtimeDBRepository: FirebaseRealtimeDBRepository()),
      child: const SignUpVerifyView()
    );
  }
}