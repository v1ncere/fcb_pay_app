part of 'scanner_transaction_bloc.dart';

class ScannerTransactionState extends Equatable with FormzMixin {
  const ScannerTransactionState({
    this.qrDataList = const <QRModel>[],
    this.accountDropdown = const AccountDropdown.pure(),
    this.inputAmount = const Amount.pure(),
    this.status = Status.initial,
    this.formStatus = FormzSubmissionStatus.initial,
    this.message = ''
  });
  final List<QRModel> qrDataList;
  final AccountDropdown accountDropdown;
  final Amount inputAmount;
  final Status status;
  final FormzSubmissionStatus formStatus;
  final String message;

  ScannerTransactionState copyWith({
    List<QRModel>? qrDataList,
    AccountDropdown? accountDropdown,
    Amount? inputAmount,
    Status? status,
    FormzSubmissionStatus? formStatus,
    String? message
  }) {
    return ScannerTransactionState(
      qrDataList: qrDataList ?? this.qrDataList,
      accountDropdown: accountDropdown ?? this.accountDropdown,
      inputAmount: inputAmount ?? this.inputAmount,
      status: status ?? this.status,
      formStatus: formStatus ?? this.formStatus,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [
    qrDataList,
    accountDropdown,
    inputAmount,
    status,
    formStatus,
    message,
    isValid,
    isPure
  ];
  
  @override
  List<FormzInput> get inputs => [accountDropdown, inputAmount];
}
