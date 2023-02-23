import 'package:formz/formz.dart';

enum ConfirmedPasswordValidationError {
  required('Confirm password can\'t be empty.'),
  invalid('Confirm password not match. Please try again.');

  const ConfirmedPasswordValidationError(this.message);
  final String message;
}

class ConfirmedPassword extends FormzInput<String, ConfirmedPasswordValidationError> {
  const ConfirmedPassword.pure({
    this.password = ''
  }) : super.pure('');

  const ConfirmedPassword.dirty({
    required this.password,
    String value = ''
  }) : super.dirty(value);

  final String password;

  @override
  ConfirmedPasswordValidationError? validator(String value) {
    return value.isEmpty
      ? ConfirmedPasswordValidationError.required
      : password == value 
        ? null 
        : ConfirmedPasswordValidationError.invalid;
  }
}