part of 'account_register_bloc.dart';

class AccountRegisterState extends Equatable with FormzMixin {
  const AccountRegisterState({
    this.accountNumber = const AccountNumber.pure(),
    this.name = const Name.pure(),
    this.status = FormzSubmissionStatus.initial,
  });

  final AccountNumber accountNumber;
  final Name name;
  final FormzSubmissionStatus status;

  AccountRegisterState copyWith({
    AccountNumber? accountNumber,
    Name? name,
    FormzSubmissionStatus? status,
  }) {
    return AccountRegisterState(
      accountNumber: accountNumber ?? this.accountNumber,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [accountNumber, name, status, isValid, isPure];
  
  @override
  List<FormzInput> get inputs => [accountNumber, name];
}
