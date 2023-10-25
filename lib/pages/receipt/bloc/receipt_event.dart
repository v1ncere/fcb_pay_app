part of 'receipt_bloc.dart';

abstract class ReceiptEvent extends Equatable {
  const ReceiptEvent();

  @override
  List<Object> get props => [];
}

class ReceiptDisplayLoaded extends ReceiptEvent {}

class ReceiptDisplayUpdated extends ReceiptEvent {
  const ReceiptDisplayUpdated(this.receipts);
  final Map<String, dynamic> receipts;

  @override
  List<Object> get props => [receipts];
}

// class ReceiptDisplayUpdated extends ReceiptEvent {
//   const ReceiptDisplayUpdated(this.receipts);
//   final Receipt receipts;

//   @override
//   List<Object> get props => [receipts];
// }