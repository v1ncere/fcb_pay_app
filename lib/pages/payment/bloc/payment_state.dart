part of 'payment_bloc.dart';

class PaymentState extends Equatable with FormzMixin {
  const PaymentState({
    this.amount = const Amount.pure(),
    this.institutionDropdown = const InstitutionDropdown.pure(),
    this.accountDropdown = const AccountDropdown.pure(),
    this.controllers = const <TextEditingController>[],
    this.fields = const <TextField>[],
    this.fieldList = const <String>[],
    this.additional = "",
    this.status = FormzSubmissionStatus.initial,
    this.error = ""
  });

  final Amount amount;
  final InstitutionDropdown institutionDropdown;
  final AccountDropdown accountDropdown;
  final List<TextEditingController> controllers;
  final List<TextField> fields;
  final List<String> fieldList;
  final String additional;
  final FormzSubmissionStatus status;
  final String error;

  PaymentState copyWith({
    Amount? amount,
    InstitutionDropdown? institutionDropdown,
    AccountDropdown? accountDropdown,
    List<TextEditingController>? controllers,
    List<TextField>? fields,
    List<String>? fieldList,
    String? additional,
    FormzSubmissionStatus? status,
    String? error,
  }) {
    return PaymentState(
      amount: amount ?? this.amount,
      institutionDropdown: institutionDropdown ?? this.institutionDropdown,
      accountDropdown: accountDropdown ?? this.accountDropdown,
      controllers: controllers ?? this.controllers,
      fields: fields ?? this.fields,
      fieldList: fieldList ?? this.fieldList,
      additional: additional ?? this.additional,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    amount,
    institutionDropdown,
    accountDropdown,
    controllers,
    fields,
    fieldList,
    additional,
    status,
    error,
    isValid,
    isPure
  ];
  
  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [amount, institutionDropdown, accountDropdown];
}