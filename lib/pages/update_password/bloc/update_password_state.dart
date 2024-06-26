part of 'update_password_bloc.dart';

class UpdatePasswordState extends Equatable with FormzMixin {
  const UpdatePasswordState({
    this.newPassword = const Password.pure(),
    this.confirmNewPassword = const ConfirmedPassword.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isPasswordObscure = true,
    this.isNewPasswordObscure = true,
    this.isConfirmNewPasswordObscure = true,
    this.message,
  });
  final Password newPassword;
  final ConfirmedPassword confirmNewPassword;
  final FormzSubmissionStatus status;
  final bool isPasswordObscure;
  final bool isNewPasswordObscure;
  final bool isConfirmNewPasswordObscure;
  final String? message;

  UpdatePasswordState copyWith({
    Password? newPassword,
    ConfirmedPassword? confirmNewPassword,
    FormzSubmissionStatus? status,
    bool? isPasswordObscure,
    bool? isNewPasswordObscure,
    bool? isConfirmNewPasswordObscure,
    String? message
  }) {
    return UpdatePasswordState(
      newPassword: newPassword ?? this.newPassword,
      confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
      status: status ?? this.status,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      isNewPasswordObscure: isNewPasswordObscure ?? this.isNewPasswordObscure,
      isConfirmNewPasswordObscure: isConfirmNewPasswordObscure ?? this.isConfirmNewPasswordObscure,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object?> get props => [
    newPassword,
    confirmNewPassword,
    status,
    isPasswordObscure,
    isNewPasswordObscure,
    isConfirmNewPasswordObscure,
    message,
    isValid
  ];
  
  @override
  List<FormzInput> get inputs => [ newPassword, confirmNewPassword ];
}
