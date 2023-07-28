part of 'scanner_display_bloc.dart';

enum ScannerDisplayStatus { initial, loading, success, failure }

class ScannerDisplayState extends Equatable {
  const ScannerDisplayState({
    this.qrData = const <QRModel>[],
    this.status = ScannerDisplayStatus.initial,
    this.error = ''
  });
  final List<QRModel> qrData;
  final ScannerDisplayStatus status;
  final String error;

  ScannerDisplayState copyWith({
    List<QRModel>? qrData,
    ScannerDisplayStatus? status,
    String? error
  }) {
    return ScannerDisplayState(
      qrData: qrData ?? this.qrData,
      status: status ?? this.status,
      error: error ?? this.error
    );
  }
  
  @override
  List<Object> get props => [
    qrData,
    error,
    status,
  ];
}

extension ScannerDisplayStatusX on ScannerDisplayStatus {
  bool get isInitial => this == ScannerDisplayStatus.initial;
  bool get isLoading => this == ScannerDisplayStatus.loading;
  bool get isSuccess => this == ScannerDisplayStatus.success;
  bool get isFailure => this == ScannerDisplayStatus.failure;
}
