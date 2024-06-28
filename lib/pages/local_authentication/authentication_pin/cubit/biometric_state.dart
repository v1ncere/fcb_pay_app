part of 'biometric_cubit.dart';

class BiometricState extends Equatable {
  const BiometricState({
    this.status = BiometricStatus.initial,
    this.message = '',
    this.biometricsEnabled = false
  });
  final BiometricStatus status;
  final String message;
  final bool biometricsEnabled;

  BiometricState copyWith({
    BiometricStatus? status,
    String? message,
    bool? biometricsEnabled
  }) {
    return BiometricState(
      status: status ?? this.status,
      message: message ?? this.message,
      biometricsEnabled: biometricsEnabled ?? this.biometricsEnabled
    );
  }

  @override
  List<Object> get props => [status, message, biometricsEnabled];
}

enum BiometricStatus {
  initial,
  enabled,
  authenticated,
  unauthenticated,
  unsupported,
  disabled
}

extension BiometricStatusX on BiometricStatus {
  bool get isInitial => this == BiometricStatus.initial;
  bool get isEnabled => this == BiometricStatus.enabled;
  bool get isAuthenticated => this == BiometricStatus.authenticated;
  bool get isUnauthenticated => this == BiometricStatus.unauthenticated;
  bool get isUnsupported => this == BiometricStatus.unsupported;
  bool get isDisabled => this == BiometricStatus.disabled;
}
