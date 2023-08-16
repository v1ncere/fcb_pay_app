part of 'scanner_transaction_bloc.dart';

abstract class ScannerTransactionEvent extends Equatable {
  const ScannerTransactionEvent();

  @override
  List<Object> get props => [];
}

class ScannerTransactionDisplayLoaded extends ScannerTransactionEvent {}

class ScannerAccountValueChanged extends ScannerTransactionEvent {
  const ScannerAccountValueChanged(this.account);
  final String account;

  @override
  List<Object> get props => [account];
}
class ScannerAmountValueChanged extends ScannerTransactionEvent {
  const ScannerAmountValueChanged(this.amount);
  final String amount;

  @override
  List<Object> get props => [amount];
}

class ScannerTransactionSubmitted extends ScannerTransactionEvent {}