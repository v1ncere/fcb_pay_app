import 'package:formz/formz.dart';

enum FilterDropdownValidationError { invalid, empty }

class FilterDropdown extends FormzInput<String?, FilterDropdownValidationError> {
  const FilterDropdown.pure() : super.pure(null);
  const FilterDropdown.dirty([String? value = '']) : super.dirty(value);

  @override
  FilterDropdownValidationError? validator(String? value) {
    return value?.isEmpty == true
      ? FilterDropdownValidationError.empty
      : null;
  }
}

extension FilterDropdownValidationErrorX on FilterDropdownValidationError {
  String text() {
    switch(this) {
      case FilterDropdownValidationError.empty:
        return 'Please select an option.';
      case FilterDropdownValidationError.invalid:
        return 'Something went wrong. Please try again later.';
    }
  }
}