import 'package:formz/formz.dart';

enum LettersValidationError {
  invalid
}

class Letter extends FormzInput<String, LettersValidationError> {
  const Letter.pure() : super.pure('');
  const Letter.dirty([super.value = '']) : super.dirty();

  static final RegExp _addressRegExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]');

  @override
  LettersValidationError? validator(String? value) {
    return _addressRegExp.hasMatch(value ?? '')
      ? null
      : LettersValidationError.invalid;
  }
}