part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
    this.args = '',
    this.buttonModel = ButtonModel.empty,
    this.accountModel = AccountModel.empty
  });
  final AppStatus status;
  final User user;
  final String args;
  final ButtonModel buttonModel;
  final AccountModel accountModel;

  const AppState.authenticated(User user) : this._(status: AppStatus.authenticated, user: user);
  
  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  const AppState.accountsDynamic(AccountModel accountModel) : this._(status: AppStatus.account, accountModel: accountModel);

  const AppState.notificationViewer(String args) : this._(status: AppStatus.notificationViewer, args: args);

  const AppState.dynamicPageViewer(ButtonModel buttonModel) : this._(status: AppStatus.dynamicPage, buttonModel: buttonModel);

  const AppState.accountDynamicPageViewer(ButtonModel buttonModel) : this._(status: AppStatus.accountDynamicPage, buttonModel: buttonModel);

  @override
  List<Object> get props => [status, user, args, buttonModel, accountModel];
}
