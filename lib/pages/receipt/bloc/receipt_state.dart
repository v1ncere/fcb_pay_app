part of 'receipt_bloc.dart';

abstract class ReceiptState extends Equatable {
  const ReceiptState();
  
  @override
  List<Object> get props => [];
}

class ReceiptDisplayLoading extends ReceiptState {}

class ReceiptDisplaySuccess extends ReceiptState {
  const ReceiptDisplaySuccess({required this.receipts});
  final Receipt receipts;

  @override
  List<Object> get props => [receipts];
}

class ReceiptDisplayError extends ReceiptState {
  const ReceiptDisplayError({required this.error});
  final String error;

  @override
  List<Object> get props => [error];
}
