part of 'scanner_transaction_bloc.dart';

sealed class ScannerTransactionEvent extends Equatable {
  const ScannerTransactionEvent();

  @override
  List<Object> get props => [];
}

final class ScannerTransactionDisplayLoaded extends ScannerTransactionEvent {}

final class ScannerAccountValueChanged extends ScannerTransactionEvent {
  const ScannerAccountValueChanged(this.account);
  final String account;

  @override
  List<Object> get props => [account];
}

final class ScannerTipValueChanged extends ScannerTransactionEvent {
  const ScannerTipValueChanged(this.tip);
  final String tip;

  @override
  List<Object> get props => [tip];
}

final class ScannerAccountModelChanged extends ScannerTransactionEvent {
  const ScannerAccountModelChanged(this.account);
  final Account account;

  @override
  List<Object> get props => [account];
}

final class ScannerAmountValueChanged extends ScannerTransactionEvent {
  const ScannerAmountValueChanged(this.amount);
  final String amount;

  @override
  List<Object> get props => [amount];
}

final class ScannerExtraWidgetValueChanged extends ScannerTransactionEvent {
  const ScannerExtraWidgetValueChanged({
    required this.id,
    required this.title,
    required this.data,
    required this.widget
  });
  final String id;
  final String title;
  final String data;
  final String widget;

  @override
  List<Object> get props => [id, title, data, widget];
}

final class ScannerTransactionSubmitted extends ScannerTransactionEvent {}