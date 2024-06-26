part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
    this.args = ''
  });
  final AppStatus status;
  final User user;
  final String args;

  // caching user
  const AppState.authenticated(User user) : this._(status: AppStatus.authenticated, user: user);
  // user logout
  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);
  // 
  const AppState.otpVerification(String args) : this._(status: AppStatus.otp, args: args);
 
  @override
  List<Object?> get props => [args, status, user];
}

enum AppStatus {
  signupVerify,
  signup,
  unauthenticated,
  authenticated,
  otp,
  mfa,
  createPin,
  updatePin
}