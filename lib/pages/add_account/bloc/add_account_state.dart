part of 'add_account_bloc.dart';

class AddAccountState extends Equatable with FormzMixin {
  const AddAccountState({
    this.accountNumber = const AccountNumber.pure(),
    this.name = const Name.pure(),
    this.status = FormzSubmissionStatus.initial,
  });

  final AccountNumber accountNumber;
  final Name name;
  final FormzSubmissionStatus status;

  AddAccountState copyWith({
    AccountNumber? accountNumber,
    Name? name,
    FormzSubmissionStatus? status,
  }) {
    return AddAccountState(
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
