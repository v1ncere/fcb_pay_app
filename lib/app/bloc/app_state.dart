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
  dynamicPage,
  dynamicReceipt,
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
    this.args = '',
    this.buttonModel = const ButtonModel(),
  });
  final AppStatus status;
  final User user;
  final String args;
  final ButtonModel buttonModel;

  const AppState.authenticated(User user) : this._(status: AppStatus.authenticated, user: user);
  
  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  const AppState.accounts(String args) : this._(status: AppStatus.account, args: args);

  const AppState.notificationViewer(String args) : this._(status: AppStatus.notificationViewer, args: args);

  const AppState.dynamicPageViewer(ButtonModel buttonModel) : this._(status: AppStatus.dynamicPage, buttonModel: buttonModel);

  @override
  List<Object> get props => [status, user, args, buttonModel];
}

class ButtonModel {
  const ButtonModel({
    this.id,
    this.title,
    this.icon,
    this.iconColor
  });
  final String? id;
  final String? title;
  final String? icon;
  final String? iconColor;

  ButtonModel copyWith({
    String? id,
    String? title,
    String? icon,
    String? iconColor,
  }) {
    return ButtonModel(
      id: id ?? this.id,
      title: title ?? this.id,
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor
    );
  }
}
