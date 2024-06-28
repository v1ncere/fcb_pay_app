part of 'receipt_bloc.dart';

sealed class ReceiptEvent extends Equatable {
  const ReceiptEvent();

  @override
  List<Object> get props => [];
}

final class ReceiptDisplayLoaded extends ReceiptEvent {}

final class ReceiptDisplayUpdated extends ReceiptEvent {
  const ReceiptDisplayUpdated(this.receiptMap);
  final Map<String, dynamic> receiptMap;

  @override
  List<Object> get props => [receiptMap];
}