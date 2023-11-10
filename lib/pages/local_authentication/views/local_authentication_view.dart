import 'package:fcb_pay_app/pages/local_authentication/cubit/biometric_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalAuthenticationView extends StatelessWidget {
  const LocalAuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BiometricCubit, BiometricState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status.isAuthenticated) {
            return const Center(
              child: Text("Authenticated"),
            );
          }
          if (state.status.isUnauthenticated) {
            return const Center(
              child: Text("UnAuthenticated"),
            );
          }
          if (state.status.isUnsupported) {
            return const Center(
              child: Text("Biometrics Unsupported"),
            );
          }
          if (state.status.isDisabled) {
            return const Center(
              child: Text("Biometrics disabled"),
            );
          }
          else {
            return const Center(child: Text("default"));
          }
        },
      )
    );
  }
}