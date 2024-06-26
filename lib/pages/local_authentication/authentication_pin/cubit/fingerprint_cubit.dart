import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_pin_repository/hive_pin_repository.dart';

part 'fingerprint_state.dart';

class FingerprintCubit extends Cubit<FingerprintState> {
  FingerprintCubit({
    required HivePinRepository hivePinRepository,
  }) : _hivePinRepository = hivePinRepository,
  super(const FingerprintState());
  final HivePinRepository _hivePinRepository;

  Future<void> getBiometricsStatus() async {
    emit(state.copyWith(status: FingerprintStatus.loading));
    try {
      final biometric = await _hivePinRepository.getBiometricStatus();
      emit(state.copyWith(status: FingerprintStatus.success, biometric: biometric));
    } catch (_) {
      emit(state.copyWith(status: FingerprintStatus.failure));
    }
  }

  void toggleBiometricStatus() async {
    try {
      final status = state.biometric == false ? true : false;
      _hivePinRepository.addBiometricStatus(status);
      emit(state.copyWith(biometric: status));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
