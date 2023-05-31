part of 'scanner_transaction_bloc.dart';

class ScannerTransactionState extends Equatable with FormzMixin {
  const ScannerTransactionState({
    this.amount = const Amount.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.error
  });
  final Amount amount;
  final FormzSubmissionStatus status;
  final String? error;

  ScannerTransactionState copyWith({
    Amount? amount,
    FormzSubmissionStatus? status,
    String? error
  })  {
    return ScannerTransactionState(
      amount: amount ?? this.amount,
      status: status ?? this.status,
      error: error ?? this.error
    );
  }
  
  @override
  List<Object> get props => [amount, status, isValid, isPure];
  
  @override
  List<FormzInput> get inputs => [amount];
}
