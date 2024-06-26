part of 'auth_checker_bloc.dart';

sealed class AuthCheckerEvent extends Equatable {
  const AuthCheckerEvent();

  @override
  List<Object> get props => [];
}

final class AuthCheckerPinChecked extends AuthCheckerEvent {}