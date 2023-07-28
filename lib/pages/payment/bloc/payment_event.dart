part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
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

class UserWidgetFetched extends PaymentEvent {
  const UserWidgetFetched(this.select);
  final String select;

  @override
  List<Object> get props => [select];
}

class AmountTextFieldChanged extends PaymentEvent {
  const AmountTextFieldChanged(this.amount);
  final String amount;

  @override
  List<Object> get props => [amount];
}

/// ============================================================================

class AdditionalTextFieldValueChanged extends PaymentEvent {
  const AdditionalTextFieldValueChanged({
    required this.keyId,
    required this.fieldTitle,
    required this.value
  });
  final String keyId;
  final String fieldTitle;
  final String value;

  @override
  List<Object> get props => [keyId, fieldTitle, value];
}

class AdditionalFieldDisplayed extends PaymentEvent {}

/// ============================================================================

class PaymentSubmitted extends PaymentEvent {
  const PaymentSubmitted(this.account);
  final String account;

  @override
  List<Object> get props => [account];
}