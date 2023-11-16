import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_pin_repository/hive_pin_repository.dart';
import 'package:local_auth/local_auth.dart';

import 'package:fcb_pay_app/utils/utils.dart';

part 'biometric_state.dart';

class BiometricCubit extends Cubit<BiometricState> {
  BiometricCubit({
    required LocalAuthentication localAuth,
    required HivePinRepository hivePinRepository,
  }) : _localAuth = localAuth, _hivePinRepository = hivePinRepository,
  super(const BiometricState());
  final LocalAuthentication _localAuth;
  final HivePinRepository _hivePinRepository;

  Future<void> isBiometricUserEnabled() async {
    try {
      final isEnable = await _hivePinRepository.isBiometricsUserEnable();
      emit(state.copyWith(biometricsEnabled: isEnable));
      
      if (isEnable) {
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
          final bool isAuthenticated = await _localAuth.authenticate(
            localizedReason: AppString.localizedReason,
            options: const AuthenticationOptions(
              biometricOnly: true,
              stickyAuth: true,
              useErrorDialogs: false,
              sensitiveTransaction: true,
            )
          );
          if (isAuthenticated) {
            emit(state.copyWith(status: BiometricStatus.authenticated, message: AppString.authSuccess));
          } else {
            emit(state.copyWith(status: BiometricStatus.unauthenticated, message: AppString.authFailure));
          }
        } on PlatformException catch (e) {
          emit(state.copyWith(status: BiometricStatus.unauthenticated, message: 'Error: ${e.message}'));
        } catch (e) {
          emit(state.copyWith(status: BiometricStatus.unauthenticated, message: e.toString()));
        }
      } else {
        emit(state.copyWith(status: BiometricStatus.disabled, message: AppString.biometricDisabled));
      }
    } else {
      emit(state.copyWith(status: BiometricStatus.unsupported, message: AppString.biometricUnsupported));
    }
  }

  void refreshState() {
    emit(state.copyWith(status: BiometricStatus.initial, message: ''));
  }

  void toggleBiometrics(bool isEnabled) {
    try {
      _hivePinRepository.addBiometrics(isEnabled);
      emit(state.copyWith(biometricsEnabled: isEnabled));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> close() async {
    _hivePinRepository.closeBioBox();
    super.close();
  }
}