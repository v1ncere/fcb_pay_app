part of 'payment_confirmation_bloc.dart';

enum PaymentConfirmationStatus { initial, loading, success, failure }

extension PaymentConfirmationStatusX on PaymentConfirmationStatus {
  bool get isInitial => this == PaymentConfirmationStatus.initial;
  bool get isLoading => this == PaymentConfirmationStatus.loading;
  bool get isSuccess => this == PaymentConfirmationStatus.success;
  bool get isFailure => this == PaymentConfirmationStatus.failure;
}

class PaymentConfirmationState extends Equatable {
  const PaymentConfirmationState({
    this.status = PaymentConfirmationStatus.initial,
    this.display = '',
    this.error = '',
  });
  final PaymentConfirmationStatus status;
  final String display;
  final String error;

  PaymentConfirmationState copyWith({
    PaymentConfirmationStatus? status,
    String? display,
    String? error,
  }) {
    return PaymentConfirmationState(
      status: status ?? this.status,
      display: display ?? this.display,
      error: error ?? this.error,
    );
  }
  
  @override
  List<Object> get props => [status, display, error];
}
