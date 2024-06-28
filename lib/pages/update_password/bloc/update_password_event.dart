part of 'update_password_bloc.dart';

sealed class UpdatePasswordEvent extends Equatable {
  const UpdatePasswordEvent();

  @override
  List<Object> get props => [];
}

final class UpdateNewPasswordChanged extends UpdatePasswordEvent {
  const UpdateNewPasswordChanged(this.newPassword);
  final String newPassword;

  @override
  List<Object> get props => [newPassword];
}

final class UpdateConfirmNewPasswordChanged extends UpdatePasswordEvent {
  const UpdateConfirmNewPasswordChanged(this.confirmPassword);
  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

final class UpdatePasswordObscured extends UpdatePasswordEvent {}

final class UpdateNewPasswordObscured extends UpdatePasswordEvent {}

final class UpdateConfirmNewPasswordObscured extends UpdatePasswordEvent {}

final class PasswordUpdateSubmitted extends UpdatePasswordEvent {}
