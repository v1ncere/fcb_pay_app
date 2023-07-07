import 'package:formz/formz.dart';

enum ConfirmedPasswordValidationError { required, invalid }

class ConfirmedPassword extends FormzInput<String, ConfirmedPasswordValidationError> {
  const ConfirmedPassword.pure({this.password = ''}) : super.pure('');
  const ConfirmedPassword.dirty({required this.password, String value = ''}) : super.dirty(value);
  final String password;

  @override
  ConfirmedPasswordValidationError? validator(String? value) {
    return value?.isEmpty == true
    ? ConfirmedPasswordValidationError.required
    : password == value
      ? null
      : ConfirmedPasswordValidationError.invalid;
  }
}

extension ConfirmedPasswordValidationErrorX on ConfirmedPasswordValidationError {
  String text() {
    switch (this) {
      case ConfirmedPasswordValidationError.required:
        return 'Confirm password is required';
      case ConfirmedPasswordValidationError.invalid:
        return 'Confirm password not match. Please try again.';
    }
  }
}