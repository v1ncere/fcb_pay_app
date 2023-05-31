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

class InstitutionValueChanged extends PaymentEvent {
  const InstitutionValueChanged(this.institution);
  final String institution;

  @override
  List<Object> get props => [institution];
}

class AccountValueChanged extends PaymentEvent {
  const AccountValueChanged(this.account);
  final String account;

  @override
  List<Object> get props => [account];
}

class PaymentSubmitted extends PaymentEvent {}