import 'package:formz/formz.dart';

enum AmountValidationError { required, invalid }

class Amount extends FormzInput<String, AmountValidationError> {
  const Amount.pure() : super.pure('');
  const Amount.dirty([super.value = '']) : super.dirty();
  // static final _numbersRegex = RegExp(r'^\d+(?:.\d+)?$');
  static final _numbersRegex = RegExp(r'^[-\\+]?\s*((\d{1,3}(,\d{3})*)|\d+)(\.\d{2})?$');

  @override
  AmountValidationError? validator(String? value) {
    return value?.isEmpty == true
    ? AmountValidationError.required
    : _numbersRegex.hasMatch(value!)
      ? null
      : AmountValidationError.invalid;
  }
}

extension AmountValidationErrorX on AmountValidationError {
  String text() {
    switch (this) {
      case AmountValidationError.required:
        return 'Amount is required';
      case AmountValidationError.invalid:
        return 'Amount is invalid. Please try again.';
    }
  }
}