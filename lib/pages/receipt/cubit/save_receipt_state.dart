part of 'save_receipt_cubit.dart';

class SaveReceiptState extends Equatable {
  const SaveReceiptState({
    this.message = '',
    this.status = Status.initial
  });
  final String message;
  final Status status;

  SaveReceiptState copyWith({
    String? message,
    Status? status,
  }) {
    return SaveReceiptState(
      message: message ?? this.message,
      status: status ?? this.status
    );
  }

  @override
  List<Object> get props => [message, status];
}
