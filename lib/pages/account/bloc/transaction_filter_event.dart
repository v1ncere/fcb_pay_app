part of 'transaction_filter_bloc.dart';

abstract class TransactionFilterEvent extends Equatable {
  const TransactionFilterEvent();

  @override
  List<Object> get props => [];
}

class TransactionFilterLoaded extends TransactionFilterEvent {}

class TransactionFilterUpdated extends TransactionFilterEvent {
  const TransactionFilterUpdated(this.filter);
  final TransactionFilter filter;

  @override
  List<Object> get props => [filter];
}
