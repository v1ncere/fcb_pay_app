import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

part 'biometric_state.dart';

class BiometricCubit extends Cubit<BiometricState> {
  BiometricCubit({
    required LocalAuthentication localAuth
  }) : _localAuth = localAuth, super(const BiometricState());
  final LocalAuthentication _localAuth;

  Future<void> authenticationBiometricsRequested() async {
    // Check if the device supports biometric authentication.
    final bool biometricSupported = await _localAuth.isDeviceSupported();
    // If biometric authentication is supported on the device.
    if (biometricSupported) {
      // Check if the user has enabled biometric authentication.
      final bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      // If the user has enabled biometric authentication.
      if (canCheckBiometrics) {
        try {
          emit(state.copyWith(status: BiometricStatus.loading));
          // Attempt biometric authentication.
          final bool isAuthenticated = await _localAuth.authenticate(
            localizedReason: 'Scan your fingerprint to authenticate',
            options: const AuthenticationOptions(
              biometricOnly: false,
              stickyAuth: true,
              useErrorDialogs: true,
              sensitiveTransaction: true
            )
          );
          // If authentication is successful, emit an authenticated state.
          if (isAuthenticated) {
            emit(state.copyWith(status: BiometricStatus.authenticated));
          }
          // If authentication fails, emit an unauthenticated state with an error message.
          else {
            emit(state.copyWith(status: BiometricStatus.unauthenticated, message: 'Authentication failed'));
          }
        }
        // If an error occurs during authentication, emit an unauthenticated state with an error message.
        catch (e) {
          emit(state.copyWith(status: BiometricStatus.unauthenticated, message: e.toString()));
        }
      }
      // If the user has not enabled biometric authentication, emit a disabled state with a message. 
      else {
        emit(state.copyWith(status: BiometricStatus.disabled, message: 'Biometric authentication disabled'));
      }
    }
    // If biometric authentication is not supported on the device, emit an unsupported state with a message.
    else {
      emit(state.copyWith(status: BiometricStatus.unsupported, message: 'Biometric authentication is not supported'));
    }
  }
}