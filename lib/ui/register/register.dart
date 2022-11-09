import 'package:fcb_pay_app/ui/register/stepper/cubit/stepper_cubit.dart';
import 'package:fcb_pay_app/ui/register/stepper/stepper_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => RegisterCubit(context.read<AuthenticationRepository>())),
        BlocProvider(create: (context) => StepperCubit(3)),
      ],
      child: const StepperWidget()
    );
  }
}