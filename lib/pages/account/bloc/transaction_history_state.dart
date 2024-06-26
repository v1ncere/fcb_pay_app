part of 'transaction_history_bloc.dart';

class TransactionHistoryState extends Equatable {
  const TransactionHistoryState({
    this.transactionList = const <TransactionHistory>[],
    this.searchQuery = const Search.pure(),
    this.formStatus = FormzSubmissionStatus.initial,
    this.status = Status.initial,
    this.message = ''
  });

  final List<TransactionHistory> transactionList;
  final Search searchQuery;
  final FormzSubmissionStatus formStatus;
  final Status status;
  final String message;

  TransactionHistoryState copyWith({
    List<TransactionHistory>? transactionList,
    Search? searchQuery,
    FormzSubmissionStatus? formStatus,
    Status? status,
    String? message
  }) {
    return TransactionHistoryState(
      transactionList: transactionList ?? this.transactionList,
      searchQuery: searchQuery ?? this.searchQuery,
      formStatus: formStatus ?? this.formStatus,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [transactionList, searchQuery, formStatus, status, message];
}

