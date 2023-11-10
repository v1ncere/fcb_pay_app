import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import 'package:fcb_pay_app/pages/local_authentication/local_authentication.dart';

class LocalAuthenticationPage extends StatelessWidget {
  const LocalAuthenticationPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: LocalAuthenticationPage()); 
  
  static final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BiometricCubit(localAuth: _localAuth)..authenticationBiometricsRequested())
      ],
      child: const LocalAuthenticationView(),
    );
  }
}