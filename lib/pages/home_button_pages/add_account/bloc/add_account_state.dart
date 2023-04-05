part of 'add_account_bloc.dart';

class AddAccountState extends Equatable with FormzMixin {
  const AddAccountState({
    this.accountNumber = const AccountNumber.pure(),
    this.status = FormzSubmissionStatus.initial,
  });

  final AccountNumber accountNumber;
  final FormzSubmissionStatus status;

  AddAccountState copyWith({
    AccountNumber? accountNumber,
    FormzSubmissionStatus? status,
  }) {
    return AddAccountState(
      accountNumber: accountNumber ?? this.accountNumber,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [accountNumber, status, isValid, isPure];
  
  @override
  List<FormzInput> get inputs => [accountNumber];
}
