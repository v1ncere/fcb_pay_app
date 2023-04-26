part of 'transaction_history_bloc.dart';

abstract class TransactionHistoryState extends Equatable {
  const TransactionHistoryState();
  
  @override
  List<Object> get props => [];
}

class TransactionHistoryLoading extends TransactionHistoryState {}

class TransactionHistoryLoad extends TransactionHistoryState {
  const TransactionHistoryLoad({this.transactions = const <TransactionHistory>[]});
  final List<TransactionHistory> transactions;

  @override
  List<Object> get props => [transactions];
}

class TransactionHistoryError extends TransactionHistoryState {
  const TransactionHistoryError(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
