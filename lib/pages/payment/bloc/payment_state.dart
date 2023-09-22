part of 'payment_bloc.dart';

class PaymentState extends Equatable with FormzMixin {
  const PaymentState({
    this.institutionDropdown = const InstitutionDropdown.pure(),
    this.accountDropdown = const AccountDropdown.pure(),
    this.widgetList = const <AdditionalWidget>[],
    this.amount = const Amount.pure(),
    this.status = Status.initial,
    this.formzStatus = FormzSubmissionStatus.initial,
    this.message = ''
  });

  final InstitutionDropdown institutionDropdown;
  final AccountDropdown accountDropdown;
  final List<AdditionalWidget> widgetList;
  final Amount amount;
  final FormzSubmissionStatus formzStatus;
  final Status status;
  final String message;

  PaymentState copyWith({
    InstitutionDropdown? institutionDropdown,
    AccountDropdown? accountDropdown,
    List<AdditionalWidget>? widgetList,
    Amount? amount,
    FormzSubmissionStatus? formzStatus,
    Status? status,
    String? message
  }) {
    return PaymentState(
      institutionDropdown: institutionDropdown ?? this.institutionDropdown,
      accountDropdown: accountDropdown ?? this.accountDropdown,
      widgetList: widgetList ?? this.widgetList,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      formzStatus: formzStatus ?? this.formzStatus,
      message: message ?? this.message
    );
  }

  @override
  List<Object?> get props => [
    institutionDropdown,
    accountDropdown,
    widgetList,
    amount,
    status,
    formzStatus,
    message,
    isValid,
    isPure
  ];

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [amount, institutionDropdown, accountDropdown];
}