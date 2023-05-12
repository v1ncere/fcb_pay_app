part of 'display_payment_data_bloc.dart';

enum DisplayPaymentDataStatus { initial, progress, success, failure }

class DisplayPaymentDataState extends Equatable {
  const DisplayPaymentDataState({
    this.merchantId = '',
    this.merchantName = '',
    this.referenceLabel = '',
    this.senderTransactionRef = '',
    this.traceNumber = '',
    this.status = DisplayPaymentDataStatus.initial,
    this.error = ''
  });
  final String merchantId;
  final String merchantName;
  final String referenceLabel;
  final String senderTransactionRef;
  final String traceNumber;
  final DisplayPaymentDataStatus status;
  final String error;
  
  DisplayPaymentDataState copyWith({
    String? merchantId,
    String? merchantName,
    String? referenceLabel,
    String? senderTransactionRef,
    String? traceNumber,
    DisplayPaymentDataStatus? status,
    String? error
  }) {
    return DisplayPaymentDataState(
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
    error
  ];
}

extension DisplayPaymentDataStatusX on DisplayPaymentDataStatus {
  bool get onInitial => this == DisplayPaymentDataStatus.initial;
  bool get onProgress => this == DisplayPaymentDataStatus.progress;
  bool get onSuccess => this == DisplayPaymentDataStatus.success;
  bool get onFailure => this == DisplayPaymentDataStatus.failure;
}

