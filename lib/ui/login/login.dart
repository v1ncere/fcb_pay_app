import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/repository/authentication_repository/authentication_repository.dart';
import 'package:fcb_pay_app/ui/login/cubit/login_cubit.dart';
import 'package:fcb_pay_app/ui/login/widgets/login_widgets.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  static Page<void> page() => const MaterialPage<void>(child: Login());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationRepository(),
        child: BlocProvider(
        create: (context) => LoginCubit(context.read<AuthenticationRepository>()),
        child: const Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
            child: LoginWidget(),
          ),
        ),
      ),
    );
  }
}