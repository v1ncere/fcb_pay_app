part of 'scanner_transaction_bloc.dart';

abstract class ScannerTransactionEvent extends Equatable {
  const ScannerTransactionEvent();

  @override
  List<Object> get props => [];
}

class ScannerAccountValueChanged extends ScannerTransactionEvent {
  const ScannerAccountValueChanged(this.amount);
  final String amount;

  @override
  List<Object> get props => [amount];
}

class ScannerTransactionSubmitted extends ScannerTransactionEvent {}
