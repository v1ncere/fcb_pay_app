import 'package:formz/formz.dart';

enum PasswordValidationError { required, invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();
  // static final _passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  static final _passwordRegExp = RegExp(r'^(?=.*[!@#$%^&*()-+=_])(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z]).{8,}$');

  @override
  PasswordValidationError? validator(String? value) {
    return value?.isEmpty == true
      ? PasswordValidationError.required
      : _passwordRegExp.hasMatch(value!)
        ? null
        : PasswordValidationError.invalid;
  }
}

extension PasswordValidationErrorX on PasswordValidationError {
  String text() {
    switch (this) {
      case PasswordValidationError.required:
        return 'Password is required';
      case PasswordValidationError.invalid:
        return 'Password is too weak. Strong password is a must.';
    }
  }
}