import 'package:formz/formz.dart';

enum DynamicTextFieldValidationError { required, invalid }

class DynamicTextField extends FormzInput<String, DynamicTextFieldValidationError> {
  final String type;
  const DynamicTextField.pure({this.type = ''}) : super.pure('');
  const DynamicTextField.dirty({String value = '', required this.type}) : super.dirty(value);

  static final regex = RegExp(r'^[-\\+]?\s*((\d{1,3}(,\d{3})*)|\d+)(\.\d{2})?$');

  @override
  DynamicTextFieldValidationError? validator(String? value) {
    if (value?.isEmpty == true) {
      return DynamicTextFieldValidationError.required;
    }
    if (type == 'int') {
      if (!regex.hasMatch(value!)) {
        return DynamicTextFieldValidationError.invalid;
      }
    }
    return null;
  }
}

extension DynamicTextFieldValidationErrorX on DynamicTextFieldValidationError {
  String text() {
    switch (this) {
      case DynamicTextFieldValidationError.required:
        return 'Input is required';
      case DynamicTextFieldValidationError.invalid:
        return 'Input is invalid. Please try again.';
    }
  }
}