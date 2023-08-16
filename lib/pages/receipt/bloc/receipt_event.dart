part of 'receipt_bloc.dart';

abstract class ReceiptEvent extends Equatable {
  const ReceiptEvent();

  @override
  List<Object> get props => [];
}

class ReceiptDisplayLoaded extends ReceiptEvent {}

class ReceiptDisplayUpdated extends ReceiptEvent {
  const ReceiptDisplayUpdated(this.receipts);
  final Receipts receipts;

  @override
  List<Object> get props => [receipts];
}