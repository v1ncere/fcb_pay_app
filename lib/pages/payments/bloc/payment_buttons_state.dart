part of 'payment_buttons_bloc.dart';

sealed class PaymentButtonsState extends Equatable {
  const PaymentButtonsState();
  
  @override
  List<Object> get props => [];
}

final class PaymentButtonsLoading extends PaymentButtonsState {}

final class PaymentButtonsSuccess extends PaymentButtonsState {
  const PaymentButtonsSuccess(this.buttons);
  final List<Button> buttons;

  @override
  List<Object> get props => [buttons];
}

final class PaymentButtonsError extends PaymentButtonsState {
  const PaymentButtonsError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
