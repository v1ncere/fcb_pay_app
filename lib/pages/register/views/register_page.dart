import 'package:fcb_pay_app/pages/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/repository/repository.dart';
import 'package:fcb_pay_app/pages/register/register.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseAuthRepository(),
      child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InputsBloc(authenticationRepository: context.read<FirebaseAuthRepository>())
        ),
        BlocProvider(
          create: (context) => StepperCubit(3)
        ),
        BlocProvider(
          create: (context) => LoginCubit(context.read<FirebaseAuthRepository>())
        )
      ],
      child: const StepperWidget()
      ), 
    );
  }
}