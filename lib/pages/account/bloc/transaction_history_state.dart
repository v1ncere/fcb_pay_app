part of 'transaction_history_bloc.dart';

abstract class TransactionHistoryState extends Equatable {
  const TransactionHistoryState();
  
  @override
  List<Object> get props => [];
}

class TransactionHistoryLoadInProgress extends TransactionHistoryState {}

class TransactionHistoryLoadSuccess extends TransactionHistoryState {
  const TransactionHistoryLoadSuccess({this.transactions = const <TransactionHistory>[]});
  final List<TransactionHistory> transactions;

  @override
  List<Object> get props => [transactions];
}

class TransactionHistoryLoadError extends TransactionHistoryState {
  const TransactionHistoryLoadError(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
