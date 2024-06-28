part of 'receipt_bloc.dart';

class ReceiptState extends Equatable {
  const ReceiptState({
    this.receiptMap = const {},
    this.status = Status.initial,
    this.message = ''
  });
  final Map<String, dynamic> receiptMap;
  final Status status;
  final String message;

  ReceiptState copyWith({
    Map<String, dynamic>? receiptMap,
    Status? status,
    String? message,
  }) {
    return ReceiptState(
      receiptMap: receiptMap ?? this.receiptMap,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [receiptMap, status, message];
}
