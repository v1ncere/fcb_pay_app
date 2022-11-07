import 'package:formz/formz.dart';

enum NumbersValidationError {
  invalid
}

class Number extends FormzInput<String, NumbersValidationError> {
  const Number.pure() : super.pure('');
  const Number.dirty([super.value = '']) : super.dirty();

  static final RegExp _addressRegExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');

  @override
  NumbersValidationError? validator(String? value) {
    return _addressRegExp.hasMatch(value ?? '')
      ? null
      : NumbersValidationError.invalid;
  }
}