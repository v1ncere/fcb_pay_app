import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_pin_repository/hive_pin_repository.dart';
import 'package:local_auth/local_auth.dart';

import '../../local_authentication/local_authentication.dart';
import '../settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: SettingsPage());

  static final HivePinRepository _hivePinRepository = HivePinRepository();
  static final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _hivePinRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => BiometricCubit(localAuth: _localAuth, hivePinRepository: _hivePinRepository)
          ..authenticationBiometricChecker()),
          BlocProvider(create: (context) => FingerprintCubit(hivePinRepository: _hivePinRepository)
          ..getBiometricsStatus())
        ],
        child: const SettingsView()
      )
    );
  }
}