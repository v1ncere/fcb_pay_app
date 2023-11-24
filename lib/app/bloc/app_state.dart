part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
  });
  final AppStatus status;
  final User user;

  // caching user
  const AppState.authenticated(User user) : this._(status: AppStatus.authenticated, user: user);
  // user logout
  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);
 
  @override
  List<Object?> get props => [status, user];
}

enum AppStatus {
  register,
  unauthenticated,
  authenticated,
  createPin,
  updatePin
}