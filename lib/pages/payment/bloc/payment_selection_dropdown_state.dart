part of 'payment_selection_dropdown_bloc.dart';

enum PaymentSelectionDropdownStatus { initial, progress, success, failure }

class PaymentSelectionDropdownState extends Equatable {
  const PaymentSelectionDropdownState({
    this.status = PaymentSelectionDropdownStatus.initial,
    this.institution = const<Institution>[],
    this.error,
  });
  final PaymentSelectionDropdownStatus status;
  final List<Institution> institution;
  final String? error;

  PaymentSelectionDropdownState copyWith({
    PaymentSelectionDropdownStatus? status,
    List<Institution>? institution,
    String? error,
    String? selectedValue,
  }) {
    return PaymentSelectionDropdownState(
      status: status ?? this.status,
      institution: institution ?? this.institution,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [institution, status];
}

extension PaymentSelectionDropdownStatusX on PaymentSelectionDropdownStatus {
  bool get onInitial => this == PaymentSelectionDropdownStatus.initial;
  bool get onProgress =>  this == PaymentSelectionDropdownStatus.progress;
  bool get onSuccess => this == PaymentSelectionDropdownStatus.success;
  bool get onFailure => this == PaymentSelectionDropdownStatus.failure;
} 