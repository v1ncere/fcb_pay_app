part of 'payment_bloc.dart';

enum PaymentStateStatus { initial, loading, success, error }

class PaymentState extends Equatable with FormzMixin {
  const PaymentState({
    this.institutionDropdown = const InstitutionDropdown.pure(),
    this.accountDropdown = const AccountDropdown.pure(),
    this.widgetList = const <UserWidget>[],
    this.amount = const Amount.pure(),
    this.additional = "",
    this.status = PaymentStateStatus.initial,
    this.formStatus = FormzSubmissionStatus.initial,
    this.message = ""
  });

  final InstitutionDropdown institutionDropdown;
  final AccountDropdown accountDropdown;
  final List<UserWidget> widgetList;
  final Amount amount;
  final String additional;
  final PaymentStateStatus status;
  final FormzSubmissionStatus formStatus;
  final String message;

  PaymentState copyWith({
    InstitutionDropdown? institutionDropdown,
    AccountDropdown? accountDropdown,
    List<UserWidget>? widgetList,
    Amount? amount,
    String? additional,
    PaymentStateStatus? status,
    FormzSubmissionStatus? formStatus,
    String? message,
  }) {
    return PaymentState(
      institutionDropdown: institutionDropdown ?? this.institutionDropdown,
      accountDropdown: accountDropdown ?? this.accountDropdown,
      widgetList: widgetList ?? this.widgetList,
      amount: amount ?? this.amount,
      additional: additional ?? this.additional,
      status: status ?? this.status,
      formStatus: formStatus ?? this.formStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    institutionDropdown,
    accountDropdown,
    widgetList,
    amount,
    additional,
    status,
    formStatus,
    message,
    isValid,
    isPure
  ];
  
  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [amount, institutionDropdown, accountDropdown];
}

extension PaymentStateStatusX on PaymentStateStatus {
  bool get isInitial => this == PaymentStateStatus.initial;
  bool get isLoading => this == PaymentStateStatus.loading;
  bool get isSuccess => this == PaymentStateStatus.success;
  bool get isError => this == PaymentStateStatus.error;
}