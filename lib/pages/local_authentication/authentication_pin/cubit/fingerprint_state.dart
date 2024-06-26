part of 'fingerprint_cubit.dart';

class FingerprintState extends Equatable {
  const FingerprintState({
    this.biometric = false,
    this.status = FingerprintStatus.initial
  });
  final bool biometric;
  final FingerprintStatus status;

  FingerprintState copyWith({
    bool? biometric,
    FingerprintStatus? status
  }) {
    return FingerprintState(
      biometric: biometric ?? this.biometric,
      status: status ?? this.status
    );
  }

  @override
  List<Object> get props => [ biometric, status ];
}

enum FingerprintStatus { initial, loading, success, failure }

extension FingerprintStatusX on FingerprintStatus {
  bool get isInitial => this == FingerprintStatus.initial;
  bool get isLoading => this == FingerprintStatus.loading;
  bool get isSuccess => this == FingerprintStatus.success;
  bool get isFailure => this == FingerprintStatus.failure;
}