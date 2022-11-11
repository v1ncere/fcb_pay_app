import 'package:fcb_pay_app/repository/authentication_repository/authentication_repository.dart';
import 'package:fcb_pay_app/ui/login/cubit/login_cubit.dart';
import 'package:fcb_pay_app/ui/register/form_inputs/bloc/inputs_bloc.dart';
import 'package:fcb_pay_app/ui/register/stepper/cubit/stepper_cubit.dart';
import 'package:fcb_pay_app/ui/register/stepper/stepper_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationRepository(),
      child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InputsBloc(authenticationRepository: context.read<AuthenticationRepository>())
        ),
        BlocProvider(
          create: (context) => StepperCubit(3)
        ),
        BlocProvider(
          create: (context) => LoginCubit(context.read<AuthenticationRepository>())
        )
      ],
      child: const StepperWidget()
      ), 
    );
  }
}