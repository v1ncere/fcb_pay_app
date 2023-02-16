import 'package:formz/formz.dart';

enum AccountNumberValidationError {
  required('Account number can\'t be empty'),
  invalid('This account number is invalid. Please try again.');

  const AccountNumberValidationError(this.message);
  final String message;
}

class AccountNumber extends FormzInput<String, AccountNumberValidationError> {
  const AccountNumber.pure() : super.pure('');
  const AccountNumber.dirty([super.value = '']) : super.dirty();

  static final RegExp _postalCodeRegExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');

  @override
  AccountNumberValidationError? validator(String value) {
    return value.isEmpty
      ? AccountNumberValidationError.required
      : _postalCodeRegExp.hasMatch(value)
        ? null
        : AccountNumberValidationError.invalid;
  }
}