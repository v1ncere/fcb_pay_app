part of 'transaction_history_bloc.dart';

abstract class TransactionHistoryEvent extends Equatable {
  const TransactionHistoryEvent();

  @override
  List<Object> get props => [];
}

class TransactionHistoryLoaded extends TransactionHistoryEvent {}

class TransactionHistoryUpdated extends TransactionHistoryEvent {
  const TransactionHistoryUpdated(this.transactions);
  final List<TransactionHistory> transactions;

  @override
  List<Object> get props => [transactions];
}
