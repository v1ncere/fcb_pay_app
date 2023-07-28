import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/register/register.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: RegisterPage());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseAuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => RegisterBloc(firebaseAuthRepository: FirebaseAuthRepository())),
          BlocProvider(create: (context) => RegisterStepperCubit(stepLength: 2))
        ],
        child: const RegisterStepperView()
      ) 
    );
  }
} 