part of 'add_account_bloc.dart';

class AddAccountState extends Equatable {
  const AddAccountState({
    this.accountNumber = const AccountNumber.pure(),
    this.status = FormzStatus.pure,
  });

  final AccountNumber accountNumber;
  final FormzStatus status;

  AddAccountState copyWith({
    AccountNumber? accountNumber,
    FormzStatus? status,
  }) {
    return AddAccountState(
      accountNumber: accountNumber ?? this.accountNumber,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [accountNumber, status];
}
