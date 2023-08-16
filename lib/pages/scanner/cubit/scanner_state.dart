part of 'scanner_cubit.dart';

class ScannerState extends Equatable {
  const ScannerState({
    this.status = Status.initial,
    this.message = ''
  });
  final Status status;
  final String message;

  ScannerState copyWith({
    Status? status,
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