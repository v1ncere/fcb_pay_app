import 'package:fcb_pay_app/repository/authentication_repository/authentication_repository.dart';
import 'package:fcb_pay_app/ui/login/cubit/login_cubit.dart';
import 'package:fcb_pay_app/ui/login/widgets/login_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: Login());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
      child: const LoginWidget(),
    );
  }
}