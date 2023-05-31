part of 'app_bloc.dart';

enum AppStatus {
  splash,
  unauthenticated,
  authenticated,
  payment,
  scanner,
  scannerTransaction,
  addAccount
}

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty
  });
  final AppStatus status;
  final User user;

  const AppState.splash() : this._(status: AppStatus.splash);

  const AppState.authenticated(User user) : this._(status: AppStatus.authenticated, user: user);
  
  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}
