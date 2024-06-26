part of 'accounts_home_bloc.dart';

class AccountsHomeState extends Equatable {
  const AccountsHomeState({
    this.accountList = const <Account>[],
    this.userDetails = UserDetails.empty,
    this.wallet = Account.empty,
    this.deposit = Account.empty,
    this.credit = Account.empty,
    this.status = Status.initial,
    this.userDetailStatus = Status.initial,
    this.message = ''
  });
  final UserDetails userDetails;
  final List<Account> accountList;
  final Account wallet;
  final Account deposit;
  final Account credit;
  final Status status;
  final Status userDetailStatus;
  final String message;
  
  AccountsHomeState copyWith({
    List<Account>? accountList,
    UserDetails? userDetails,
    Account? wallet,
    Account? deposit,
    Account? credit,
    Status? status,
    Status? userDetailStatus,
    String? message
  }) {
    return AccountsHomeState(
      accountList: accountList ?? this.accountList,
      userDetails: userDetails ?? this.userDetails,
      wallet: wallet ?? this.wallet,
      deposit: deposit ?? this.deposit,
      credit: credit ?? this.credit,
      status: status ?? this.status,
      userDetailStatus: userDetailStatus ?? this.userDetailStatus,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [
    accountList,
    userDetails,
    wallet,
    deposit,
    credit,
    status,
    userDetailStatus,
    message
  ]; 
}