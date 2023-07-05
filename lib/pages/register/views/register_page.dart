import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/pages/register/widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseAuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => InputsBloc(firebaseAuthService: FirebaseAuthRepository())),
          BlocProvider(create: (context) => StepperCubit(stepperLength: 3)),
        ],
        child: const StepperWidget()
      ), 
    );
  }
} 