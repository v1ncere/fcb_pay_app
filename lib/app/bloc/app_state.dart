part of 'app_bloc.dart';

enum AppStatus {
  splash,
  register,
  unauthenticated,
  authenticated,
  account,
  accountPayment,
  accountFundTransfer,
  fundTransfer,
  payment,
  scanner,
  scannerTransaction,
  addAccount,
  paymentReceipt,
  fundTransferReceipt,
  accountPaymentReceipt,
  accountFundTransferReceipt,
  scannerTransactionReceipt,
  notifications,
  notificationViewer,
}

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
    this.args = ''
  });
  final AppStatus status;
  final User user;
  final String args;

  const AppState.authenticated(User user) : this._(status: AppStatus.authenticated, user: user);
  
  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  const AppState.accounts(String args) : this._(status: AppStatus.account, args: args);

  const AppState.notificationViewer(String args) : this._(status: AppStatus.notificationViewer, args: args);

  @override
  List<Object> get props => [status, user, args];
}
