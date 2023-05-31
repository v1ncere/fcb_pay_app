part of 'scanner_display_bloc.dart';

enum ScannerDisplayStatus { initial, loading, success, failure }

class ScannerDisplayState extends Equatable {
  const ScannerDisplayState({
    this.merchantId = '',
    this.merchantName = '',
    this.referenceLabel = '',
    this.senderTransactionRef = '',
    this.traceNumber = '',
    this.status = ScannerDisplayStatus.initial,
    this.error
  });

  final String merchantId;
  final String merchantName;
  final String referenceLabel;
  final String senderTransactionRef;
  final String traceNumber;
  final ScannerDisplayStatus status;
  final String? error;

  ScannerDisplayState copyWith({
    String? merchantId,
    String? merchantName,
    String? referenceLabel,
    String? senderTransactionRef,
    String? traceNumber,
    ScannerDisplayStatus? status,
    String? error
  }) {
    return ScannerDisplayState(
      merchantId: merchantId ?? this.merchantId,
      merchantName: merchantName ?? this.merchantName,
      referenceLabel: referenceLabel ?? this.referenceLabel,
      senderTransactionRef: senderTransactionRef ?? this.senderTransactionRef,
      traceNumber: traceNumber ?? this.traceNumber,
      status: status ?? this.status,
      error: error ?? this.error
    );
  }
  
  @override
  List<Object> get props => [
    merchantId,
    merchantName,
    referenceLabel,
    senderTransactionRef,
    traceNumber,
    status,
  ];
}

extension ScannerDisplayStatusX on ScannerDisplayStatus {
  bool get isInitial => this == ScannerDisplayStatus.initial;
  bool get isLoading => this == ScannerDisplayStatus.loading;
  bool get isSuccess => this == ScannerDisplayStatus.success;
  bool get isFailure => this == ScannerDisplayStatus.failure;
}
