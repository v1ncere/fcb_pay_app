import 'package:formz/formz.dart';

enum AccountNumberValidationError { required, invalid }

class AccountNumber extends FormzInput<String, AccountNumberValidationError> {
  const AccountNumber.pure() : super.pure('');
  const AccountNumber.dirty([super.value = '']) : super.dirty();

  static final RegExp _regExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');

  @override
  AccountNumberValidationError? validator(String? value) {
    return value?.isEmpty == true
      ? AccountNumberValidationError.required
      : _regExp.hasMatch(value!)
        ? null
        : AccountNumberValidationError.invalid;
  }
}

extension AccountNumberValidationErrorExtension on AccountNumberValidationError {
  String text() {
    switch (this) {
      case AccountNumberValidationError.required:
        return 'Account number is required';
      case AccountNumberValidationError.invalid:
        return 'This account number is invalid. Please try again.';
    }
  }
}