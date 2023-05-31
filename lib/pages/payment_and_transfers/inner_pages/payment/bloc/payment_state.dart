part of 'payment_bloc.dart';

class PaymentState extends Equatable with FormzMixin {
  const PaymentState({
    this.amount = const Amount.pure(),
    this.institutionDropdown = const InstitutionDropdown.pure(),
    this.accountDropdown = const AccountDropdown.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.error,
  });

  final Amount amount;
  final InstitutionDropdown institutionDropdown;
  final AccountDropdown accountDropdown;
  final FormzSubmissionStatus status;
  final String? error;

  PaymentState copyWith({
    Amount? amount,
    InstitutionDropdown? institutionDropdown,
    AccountDropdown? accountDropdown,
    FormzSubmissionStatus? status,
    String? error,
  }) {
    return PaymentState(
      amount: amount ?? this.amount,
      institutionDropdown: institutionDropdown ?? this.institutionDropdown,
      accountDropdown: accountDropdown ?? this.accountDropdown,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [amount, institutionDropdown, accountDropdown, status, isValid, isPure];
  
  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [amount, institutionDropdown, accountDropdown];
}