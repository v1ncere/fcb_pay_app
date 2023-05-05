part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class PaymentTransactionAmountChanged extends PaymentEvent {
  const PaymentTransactionAmountChanged(this.amount);
  final String amount;

  @override
  List<Object> get props => [amount];
}

class PaymentSubmitted extends PaymentEvent {}