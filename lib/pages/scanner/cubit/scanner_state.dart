part of 'scanner_cubit.dart';

enum ScannerStateStatus {initial, loading, success, failure}

class ScannerState extends Equatable {
  const ScannerState({
    this.status = ScannerStateStatus.initial,
    this.message = ''
  });
  final ScannerStateStatus status;
  final String message;

  ScannerState copyWith({
    bool? torchOn,
    ScannerStateStatus? status,
    String? message
  }) {
    return ScannerState(
      status: status ?? this.status,
      message: message ?? this.message
    );  
  }

  @override
  List<Object> get props => [status, message];
}

extension ScannerStateStatusX on ScannerStateStatus {
  bool get isInitial => this == ScannerStateStatus.initial;
  bool get isLoading => this == ScannerStateStatus.loading;
  bool get isSuccess => this == ScannerStateStatus.success;
  bool get isFailure => this == ScannerStateStatus.failure;
}