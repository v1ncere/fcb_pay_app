part of 'payment_buttons_bloc.dart';

sealed class PaymentButtonsEvent extends Equatable {
  const PaymentButtonsEvent();

  @override
  List<Object> get props => [];
}

final class PaymentButtonsLoaded extends PaymentButtonsEvent {}

final class PaymentButtonsUpdated extends PaymentButtonsEvent {
  const PaymentButtonsUpdated(this.buttonList);
  final List<Button> buttonList;

  @override
  List<Object> get props => [buttonList];
}

final class PaymentButtonsFailed extends PaymentButtonsEvent {
  const PaymentButtonsFailed(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

final class PaymentButtonsRefreshed extends PaymentButtonsEvent {}