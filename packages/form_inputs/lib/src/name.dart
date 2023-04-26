import 'package:formz/formz.dart';

enum NameValidationError { required, invalid }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([super.value = '']) : super.dirty();
  
  @override
  NameValidationError? validator(String? value) {
    return value?.isEmpty == true
      ? NameValidationError.required
      : null;
  }
}

extension NameValidationErrorExtension on NameValidationError {
  String text() {
    switch (this) {
      case NameValidationError.required:
        return 'Name is required';
      case NameValidationError.invalid:
        return 'Name is invalid. Please try again.';
    }
  }
}