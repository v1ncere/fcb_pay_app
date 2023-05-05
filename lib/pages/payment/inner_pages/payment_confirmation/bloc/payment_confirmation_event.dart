part of 'payment_confirmation_bloc.dart';

abstract class PaymentConfirmationEvent extends Equatable {
  const PaymentConfirmationEvent();

  @override
  List<Object> get props => [];
}

class PaymentConfirmationLoaded extends PaymentConfirmationEvent {}

class PaymentConfirmationDisplayDelete extends PaymentConfirmationEvent {}

class PaymentConfirmationSubmitted extends PaymentConfirmationEvent {}