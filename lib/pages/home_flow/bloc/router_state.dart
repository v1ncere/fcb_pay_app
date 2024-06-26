part of 'router_bloc.dart';

class RouterState extends Equatable {
  const RouterState({
    this.status = HomeRouterStatus.appBar,
    this.args = '',
    this.account = Account.empty,
    this.button = Button.empty
  });
  final HomeRouterStatus status;
  final String args;
  final Account account;
  final Button button;

  RouterState copyWith({
    HomeRouterStatus? status,
    String? args,
    Account? account,
    Button? button
  }) {
    return RouterState(
      status: status ?? this.status,
      args: args ?? this.args,
      account: account ?? this.account,
      button: button ?? this.button
    );
  }

  @override
  List<Object> get props => [status, args, account, button];
}

enum HomeRouterStatus {
  appBar,
  account,
  accountsViewer,
  accountsViewerReciept,
  paymentsView,
  otp,
  paymentsReceipt,
  transfersView,
  transfersReceipt,
  scannerTransaction,
  addAccount,
  scannerTransactionReceipt,
  notifications,
  notificationViewer,
  receipt,
  settings,
  updatePassword,
  reauthenticate
}