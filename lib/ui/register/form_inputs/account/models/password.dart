import 'package:formz/formz.dart';

enum PasswordValidationError {
  required('Password can\'t be empty'),
  invalid('Password is too weak. Strong password is a must.');

  const PasswordValidationError(this.message);
  final String message;
}

class Password extends FormzInput<String, PasswordValidationError> {

  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  static final _passwordRegExp = RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");

  @override
  PasswordValidationError? validator(String value) {
    return value.isEmpty
      ? PasswordValidationError.required
      : _passwordRegExp.hasMatch(value)
        ? null
        : PasswordValidationError.invalid;
  }
}