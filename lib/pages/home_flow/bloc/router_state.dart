part of 'router_bloc.dart';

class RouterState extends Equatable {
  const RouterState._({
    required this.status,
    this.args = '',
    this.accountModel = AccountModel.empty,
    this.buttonModel = ButtonModel.empty,
  });
  final HomePageStatus status;
  final String args;
  final AccountModel  accountModel;
  final ButtonModel buttonModel;
  
  const RouterState.initial() : this._(status: HomePageStatus.appBar);
  // passing argument to account page
  const RouterState.accountsDynamic(AccountModel accountModel) 
  : this._(status: HomePageStatus.account, accountModel: accountModel);
  // passing argument to notification viewer
  const RouterState.notificationViewer(String args) 
  : this._(status: HomePageStatus.notificationViewer, args: args);
  // passing argument to dynamic viewer
  const RouterState.dynamicPageViewer(ButtonModel buttonModel) 
  : this._(status: HomePageStatus.dynamicViewer, buttonModel: buttonModel);
  // passing argument to account dynamic viewer
  const RouterState.accountDynamicPageViewer(ButtonModel buttonModel) 
  : this._(status: HomePageStatus.accountDynamicViewer, buttonModel: buttonModel);

  @override
  List<Object> get props => [status, args, accountModel, buttonModel];
}

enum HomePageStatus {
  appBar,
  account,
  accountDynamicViewer,
  accountDynamicViewerReciept,
  dynamicViewer,
  dynamicViewerReceipt,
  scannerTransaction,
  addAccount,
  scannerTransactionReceipt,
  notifications,
  notificationViewer,
}