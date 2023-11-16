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
  // caching user
  const AppState.localPin(User user) : this._(status: AppStatus.pin, user: user);
  // const AppState.authenticated(User user) : this._(status: AppStatus.authenticated, user: user);
  // user signout
  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);
  // passing argument to account page
  const AppState.accountsDynamic(AccountModel accountModel) : this._(status: AppStatus.account, accountModel: accountModel);
  // passing argument to notification viewer
  const AppState.notificationViewer(String args) : this._(status: AppStatus.notificationViewer, args: args);
  // passing argument to dynamic viewer
  const AppState.dynamicPageViewer(ButtonModel buttonModel) : this._(status: AppStatus.dynamicViewer, buttonModel: buttonModel);
  // passing argument to account dynamic viewer
  const AppState.accountDynamicPageViewer(ButtonModel buttonModel) : this._(status: AppStatus.accountDynamicViewer, buttonModel: buttonModel);

  @override
  List<Object?> get props => [status, user, args, buttonModel, accountModel];
}