import 'package:formz/formz.dart';

enum AccountDropdownValidationError { invalid, empty }

class AccountDropdown extends FormzInput<String?, AccountDropdownValidationError> {
  const AccountDropdown.pure() : super.pure(null);
  const AccountDropdown.dirty([String? value = '']) : super.dirty(value);

  @override
  AccountDropdownValidationError? validator(String? value) {
    return value == null
      ? AccountDropdownValidationError.empty
      : null;
  }
}

extension AccountDropdownValidationErrorX on AccountDropdownValidationError {
  String text() {
    switch(this) {
      case AccountDropdownValidationError.empty:
        return 'Please select an option.';
      case AccountDropdownValidationError.invalid:
        return 'Something went wrong. Please try again later.';
    }
  }
}