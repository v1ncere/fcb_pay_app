part of 'fund_transfer_bloc.dart';

class FundTransferState extends Equatable with FormzMixin {
  const FundTransferState({
    this.amount = const Amount.pure(),
    this.sourceDropdown = const AccountDropdown.pure(),
    this.recipientDropdown = const AccountDropdown.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.message = const Message.pure(),
    this.error = ''
  });
  final Amount amount;
  final AccountDropdown sourceDropdown;
  final AccountDropdown recipientDropdown;
  final FormzSubmissionStatus status;
  final Message message;
  final String error;

  FundTransferState copyWith({
    Amount? amount,
    AccountDropdown? sourceDropdown,
    AccountDropdown? recipientDropdown,
    Message? message,
    String? error,
    FormzSubmissionStatus? status
  }) {
    return FundTransferState(
      amount: amount ?? this.amount,
      sourceDropdown: sourceDropdown ?? this.sourceDropdown,
      recipientDropdown: recipientDropdown ?? this.recipientDropdown,
      message: message ?? this.message,
      error: error ?? this.error,
      status: status ?? this.status
    );
  }

  @override
  List<Object> get props => [
    amount,
    sourceDropdown,
    recipientDropdown,
    message,
    error,
    status,
    isPure,
    isValid
  ];
  
  @override
  List<FormzInput> get inputs => [amount, sourceDropdown, recipientDropdown];
}
