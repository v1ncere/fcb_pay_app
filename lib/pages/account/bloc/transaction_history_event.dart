part of 'transaction_history_bloc.dart';

sealed class TransactionHistoryEvent extends Equatable {
  const TransactionHistoryEvent();

  @override
  List<Object> get props => [];
}

final class TransactionHistoryLoaded extends TransactionHistoryEvent {
  const TransactionHistoryLoaded({
    required this.accountID,
    this.searchQuery = '',
    this.filter = '',
    this.limit = 0
  });
  final String accountID;
  final String searchQuery;
  final String filter;
  final int limit;

  @override
  List<Object> get props => [accountID, searchQuery, filter, limit];
}

final class SearchTextFieldChanged extends TransactionHistoryEvent {
  const SearchTextFieldChanged(this.searchQuery);
  final String searchQuery;

  @override
  List<Object> get props => [searchQuery];
}
