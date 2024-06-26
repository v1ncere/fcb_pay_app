part of 're_auth_bloc.dart';

sealed class ReAuthEvent extends Equatable {
  const ReAuthEvent();

  @override
  List<Object> get props => [];
}

final class ReAuthEmailChanged extends ReAuthEvent {
  const ReAuthEmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

final class ReAuthPasswordChanged extends ReAuthEvent {
  const ReAuthPasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

final class ReAuthPasswordObscured extends ReAuthEvent {}

final class ReAuthenticatedWithCredentials extends ReAuthEvent {}