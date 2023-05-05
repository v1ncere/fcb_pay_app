part of 'payment_bloc.dart';

class PaymentState extends Equatable with FormzMixin {
  const PaymentState({
    this.amount = const Amount.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.errorMsg,
  });
  final Amount amount;
  final FormzSubmissionStatus status;
  final String? errorMsg;

  PaymentState copyWith({
    Amount? amount,
    FormzSubmissionStatus? status,
    String? errorMsg,
  }) {
    return PaymentState(
      amount: amount ?? this.amount,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  List<Object> get props => [amount, status, isValid, isPure];
  
  @override
  List<FormzInput> get inputs => [amount];
}