import 'package:formz/formz.dart';

enum InstitutionDropdownValidationError { invalid, empty }

class InstitutionDropdown extends FormzInput<String?, InstitutionDropdownValidationError> {
  const InstitutionDropdown.pure() : super.pure(null);
  const InstitutionDropdown.dirty([String? value = '']) : super.dirty(value);

  @override
  InstitutionDropdownValidationError? validator(String? value) {
    return value?.isEmpty == true
      ? InstitutionDropdownValidationError.empty
      : null;
  }
}

extension InstitutionDropdownValidationErrorX on InstitutionDropdownValidationError {
  String text() {
    switch(this) {
      case InstitutionDropdownValidationError.empty:
        return 'Please select an option.';
      case InstitutionDropdownValidationError.invalid:
        return 'Something went wrong. Please try again later.';
    }
  }
}