part of 'transaction_filter_bloc.dart';

abstract class TransactionFilterState extends Equatable {
  const TransactionFilterState();
  
  @override
  List<Object> get props => [];
}

class TransactionFilterLoading extends TransactionFilterState {}

class TransactionFilterSuccess extends TransactionFilterState {
  const TransactionFilterSuccess({required this.filter});
  final TransactionFilter filter;

  @override
  List<Object> get props => [filter];
}

class TransactionFilterError extends TransactionFilterState {
  const TransactionFilterError(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}


