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

/// ============================================================================

class ControllerValueChanged extends PaymentEvent {
  const ControllerValueChanged(this.controller, this.field, this.fieldList);
  final TextEditingController controller;
  final TextField field;
  final List<String> fieldList;

  @override
  List<Object> get props => [controller, field, fieldList];
}

class ControllerValueRemoved extends PaymentEvent {}

/// ============================================================================

class PaymentSubmitted extends PaymentEvent {
  const PaymentSubmitted(this.account);
  final String account;

  @override
  List<Object> get props => [account];
}