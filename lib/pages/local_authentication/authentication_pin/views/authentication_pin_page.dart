import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_pin_repository/hive_pin_repository.dart';
import 'package:local_auth/local_auth.dart';

import '../../local_authentication.dart';

class AuthPinPage extends StatelessWidget {
  const AuthPinPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: AuthPinPage());
  
  static final HivePinRepository _hivePinRepository = HivePinRepository();
  static final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _hivePinRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthPinBloc(hivePinRepository: _hivePinRepository)),
          BlocProvider(create: (context) => BiometricCubit(
            localAuth: _localAuth,
            hivePinRepository: _hivePinRepository
          )..isBiometricUserEnabled()),
          BlocProvider(create: (context) => AuthCheckerBloc(hivePinRepository: _hivePinRepository)
          ..add(AuthCheckerPinChecked()))
        ],
        child: const AuthPinView()
      )
    );
  }
}