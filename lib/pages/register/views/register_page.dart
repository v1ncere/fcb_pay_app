import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/login/login.dart';
import 'package:fcb_pay_app/pages/register/register.dart';
import 'package:fcb_pay_app/repository/repository.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseAuthService(),
      child: MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(context.read<FirebaseAuthService>())),
        BlocProvider(create: (context) => InputsBloc(authService: context.read<FirebaseAuthService>())),
        BlocProvider(create: (context) => StepperCubit(3)),
      ],
      child: const StepperWidget()
      ), 
    );
  }
}