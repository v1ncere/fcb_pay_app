import 'package:formz/formz.dart';

enum TextfieldListValidationError { required, invalid }

class TextfieldList extends FormzInput<List<String>, TextfieldListValidationError> {
  const TextfieldList.pure() : super.pure(const <String>[]);
  const TextfieldList.dirty([super.value = const <String>[]]) : super.dirty();
  
  @override
  TextfieldListValidationError? validator(List<String>? value) {
    return value?.isEmpty == true
      ? TextfieldListValidationError.required
      : null;
  }
}

extension TextfieldListValidationErrorX on TextfieldListValidationError {
  String text() {
    switch (this) {
      case TextfieldListValidationError.required:
        return 'Name is required';
      case TextfieldListValidationError.invalid:
        return 'Name is invalid. Please try again.';
    }
  }
}