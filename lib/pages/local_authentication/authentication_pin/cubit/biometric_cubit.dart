import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_pin_repository/hive_pin_repository.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../utils/utils.dart';

part 'biometric_state.dart';

class BiometricCubit extends Cubit<BiometricState> {
  BiometricCubit({
    required LocalAuthentication localAuth,
    required HivePinRepository hivePinRepository,
  })  : _localAuth = localAuth, _hivePinRepository = hivePinRepository,
  super(const BiometricState());

  final LocalAuthentication _localAuth;
  final HivePinRepository _hivePinRepository;

  Future<void> isBiometricUserEnabled() async {
    try {
      final fingerprint = await _hivePinRepository.getBiometricStatus();
      emit(state.copyWith(biometricsEnabled: fingerprint));
      
      if (fingerprint) {
        authenticationBiometricsRequested();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> authenticationBiometricsRequested() async {
    if (await _localAuth.isDeviceSupported()) {
      if (await _localAuth.canCheckBiometrics) {
        try {
          bool isAuthenticated = await _localAuth.authenticate(
            localizedReason: TextString.localizedReason,
            options: const AuthenticationOptions(
              biometricOnly: true,
              stickyAuth: true,
              useErrorDialogs: false,
              sensitiveTransaction: true,
            )
          );
          if (isAuthenticated) {
            emit(state.copyWith(status: BiometricStatus.authenticated, message: TextString.authSuccess));
            await Future.delayed(Duration.zero, () => refreshState());
          } else {
            emit(state.copyWith(status: BiometricStatus.unauthenticated, message: TextString.authFailure));
          }
        } on PlatformException catch (e) {
          emit(state.copyWith(status: BiometricStatus.unauthenticated, message: 'Error: ${e.message}'));
        } catch (e) {
          emit(state.copyWith(status: BiometricStatus.unauthenticated, message: e.toString()));
        }
      } else {
        emit(state.copyWith(status: BiometricStatus.disabled, message: TextString.biometricDisabled));
      }
    } else {
      emit(state.copyWith(status: BiometricStatus.unsupported, message: TextString.biometricUnsupported));
    }
  }

  Future<void> authenticationBiometricChecker() async {
    if (await _localAuth.isDeviceSupported()) {
      if (await _localAuth.canCheckBiometrics) {
        emit(state.copyWith(status: BiometricStatus.enabled, message: TextString.biometricEnabled));
      } else {
        emit(state.copyWith(status: BiometricStatus.disabled, message: TextString.biometricDisabled));
      }
    } else {
      emit(state.copyWith(status: BiometricStatus.unsupported, message: TextString.biometricUnsupported));
    }
  }

  void refreshState() {
    emit(state.copyWith(status: BiometricStatus.initial, message: ''));
  }
}