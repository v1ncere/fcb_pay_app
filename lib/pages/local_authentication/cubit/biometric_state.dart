part of 'biometric_cubit.dart';

class BiometricState extends Equatable {
  const BiometricState({
    this.status = BiometricStatus.unauthenticated,
    this.message = ''
  });
  final BiometricStatus status;
  final String message;

  BiometricState copyWith({
    BiometricStatus? status,
    String? message
  }) {
    return BiometricState(
      status: status ?? this.status,
      message: message ?? this.message
    );
  }

  @override
  List<Object> get props => [status, message];
}

enum BiometricStatus { loading, authenticated, unauthenticated, unsupported, disabled }

extension BiometricStatusX on BiometricStatus {
  bool get isLoading => this == BiometricStatus.loading;
  bool get isAuthenticated => this == BiometricStatus.authenticated;
  bool get isUnauthenticated => this == BiometricStatus.unauthenticated;
  bool get isUnsupported => this == BiometricStatus.unsupported;
  bool get isDisabled => this == BiometricStatus.disabled;
}
