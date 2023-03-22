part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = Account.empty
  });

  const AppState.authenticated(Account user): this._(status: AppStatus.authenticated, user: user);
  const AppState.unauthenticated(): this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final Account user;

  @override
  List<Object> get props => [status, user];
}