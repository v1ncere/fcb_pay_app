import 'package:formz/formz.dart';

enum EmailValidationError {
  required('Email can\'t be empty'),
  invalid('This email is invalid. Please try again.');

  const EmailValidationError(this.message);
  final String message;
}

class Email extends FormzInput<String, EmailValidationError> {

  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  static final RegExp _emailRegExp = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");

  @override
  EmailValidationError? validator(String value) {
    return value.isEmpty
      ? EmailValidationError.required
      : _emailRegExp.hasMatch(value)
        ? null
        : EmailValidationError.invalid;
  }
}