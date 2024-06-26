part of 'auth_checker_bloc.dart';

class AuthCheckerState extends Equatable {
  const AuthCheckerState({
    this.isPinExist = false,
    this.status = AuthCheckerStatus.initial
  });
  final bool isPinExist;
  final AuthCheckerStatus status;

  AuthCheckerState copyWith({
    bool? isPinExist,
    AuthCheckerStatus? status
  }) {
    return AuthCheckerState(
      isPinExist: isPinExist ?? this.isPinExist,
      status: status ?? this.status
    );
  }

  @override
  List<Object> get props => [isPinExist, status];
}

enum AuthCheckerStatus { initial, loading, success, failure }

extension AuthCheckerStatusX on AuthCheckerStatus {
  bool get isInitial => this == AuthCheckerStatus.initial;
  bool get isLoading => this == AuthCheckerStatus.loading;
  bool get isSuccess => this == AuthCheckerStatus.success;
  bool get isFailure => this == AuthCheckerStatus.failure;
}
