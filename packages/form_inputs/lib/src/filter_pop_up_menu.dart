import 'package:formz/formz.dart';

enum FilterPopUpMenuValidationError { invalid, empty }

class FilterPopUpMenu extends FormzInput<String?, FilterPopUpMenuValidationError> {
  const FilterPopUpMenu.pure() : super.pure(null);
  const FilterPopUpMenu.dirty([String? value = '']) : super.dirty(value);

  @override
  FilterPopUpMenuValidationError? validator(String? value) {
    return value?.isEmpty == true
      ? FilterPopUpMenuValidationError.empty
      : null;
  }
}

extension FilterPopUpMenuValidationErrorX on FilterPopUpMenuValidationError {
  String text() {
    switch(this) {
      case FilterPopUpMenuValidationError.empty:
        return 'Please select an option.';
      case FilterPopUpMenuValidationError.invalid:
        return 'Something went wrong. Please try again later.';
    }
  }
}