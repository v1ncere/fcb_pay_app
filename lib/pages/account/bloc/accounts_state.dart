part of 'accounts_bloc.dart';

class AccountsState extends Equatable {
  const AccountsState({
    this.accountList = const <Account>[],
    this.status = Status.initial,
    this.message = ''
  });
  final List<Account> accountList;
  final Status status;
  final String message;

  AccountsState copyWith({
    List<Account>? accountList,
    Status? status,
    String? message
  }) {
    return AccountsState(
      accountList: accountList ?? this.accountList,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [accountList, status, message];
}